//
//  SearchViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/21.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchClassCell.h"
#import "SearchUsersCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "MainCourseInfoViewController.h"
#import "UsersDetailViewController.h"
#import "HeaderBase.h"
#import "TittleBarForSearch.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]


@interface SearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UITextField *searchTextField;
@property (nonatomic, retain) UIButton *searchButton;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) SearchModel *searchModel;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UIView *bgView;
@end

@implementation SearchViewController
- (void)dealloc
{
    [_searchTextField release];
    [_searchButton release];
    [_collectionView release];
    [_flowLayout release];
    [_searchModel release];
    [_key release];
    [_contentLabel release];
    [_bgView release];
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.searchTextField resignFirstResponder];
    self.searchTextField.hidden = YES;
    self.searchButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    // 创建搜索框
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(75*Screen_W, 5*Screen_H, 235*Screen_W, 30*Screen_H)];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.placeholder = @"请输入搜索关键字";
    self.searchTextField.font = [UIFont systemFontOfSize:14*Screen_H];
    

    [self.navigationController.navigationBar addSubview:self.searchTextField];
    [_searchTextField release];
    
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.searchButton.layer.cornerRadius = 5*Screen_H;
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    self.searchButton.tintColor = [UIColor whiteColor];
    self.searchButton.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    self.searchButton.frame = CGRectMake(320*Screen_W, 5*Screen_H, 40*Screen_W, 30*Screen_H);
    
    [self.searchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:self.searchButton];
    
    
    self.bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [_bgView release];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.frame = CGRectMake(50*Screen_W, 150*Screen_H, 280*Screen_W, 50*Screen_H);
//    self.contentLabel.backgroundColor = [UIColor greenColor];
    self.contentLabel.text = @"你可以搜索到相关教程与用户";
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contentLabel];
    [_contentLabel release];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.bgView.backgroundColor = nightColor;
    }

    
}
- (void)changeColor:(NSNotification *)notification
{
    self.collectionView.backgroundColor = nightColor;
    self.bgView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.collectionView.backgroundColor = secondColor;
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)buttonClick:(UIButton *)btn
{
    if(self.searchTextField.text != nil)
    {
        self.key = self.searchTextField.text;
        [self.searchTextField resignFirstResponder];
        [self createCollectionView];
        [self handleData];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.collectionView.backgroundColor = nightColor;
//            [self.collectionView reloadData];
        }
        
    }
}

- (void)handleData
{
    NSString *str0 = @"http://m.shougongke.com/index.php?&c=Search&a=index";
    NSString *str1 = [NSString stringWithFormat:@"keyword=%@", self.key];
    [AFNetWorkTool postUrlString:str0 body:str1 response:JSON bodyStyle:RequestString requestHeadFile:@{@"Content-Type":@"application/x-www-form-urlencoded"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        self.searchModel = [[SearchModel alloc]init];
        [self.searchModel setValuesForKeysWithDictionary:dic];
        [_searchModel release];
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width, 60*Screen_H)];
    self.flowLayout.headerReferenceSize = CGSizeMake(100*Screen_W, 30*Screen_H);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumLineSpacing = 5*Screen_H;
    self.flowLayout.minimumInteritemSpacing = 0;
    [_flowLayout release];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113) collectionViewLayout:self.flowLayout];

    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = secondColor;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[TittleBarForSearch class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
    [self.collectionView registerClass:[SearchClassCell class] forCellWithReuseIdentifier:@"searchClassCell"];
    [self.collectionView registerClass:[SearchUsersCell class] forCellWithReuseIdentifier:@"searchUsersCell"];
    
    [self.view addSubview:self.collectionView];
    [_collectionView release];

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.searchModel.course_data.count;
    }else
    {
        return self.searchModel.user_data.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SearchClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchClassCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:[[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"host_pic"]]];
        cell.nameLabel.text = [NSString stringWithFormat:@"by%@", [[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"user_name"]];
        cell.timeLabel.text = [[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"add_time"];

        
        // 设置标签文字
        NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:[[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"subject"]];
        // 获取标红的位置和长度
        NSRange range = [[[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"subject"] rangeOfString:self.key];
        // 设置标签文字的属性
        [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:13*Screen_H]} range:range];
        // 显示在Label上
        cell.titleLabel.attributedText = attrituteString;
        
        
        return cell;
    }
    else
    {
        SearchUsersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchUsersCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"avatar"]]];
        
        // 设置标签文字
        NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:[[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"uname"]];
        // 获取标红的位置和长度
        NSRange range = [[[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"uname"] rangeOfString:self.key];
        // 设置标签文字的属性
        [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:14*Screen_H]} range:range];
        // 显示在Label上
        cell.nameLabel.attributedText = attrituteString;
        [attrituteString release];
        
        return cell;
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        
        TittleBarForSearch *titleBar = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
        
//        titleBar.backgroundColor = [UIColor clearColor];
        if (indexPath.section == 0) {
            titleBar.titleBarLabel.text = @"  相关教程";

        }
        else if (indexPath.section == 1)
        {
            titleBar.titleBarLabel.text = @"  相关用户";

        }
        
        return titleBar;
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MainCourseInfoViewController *mainCourseInfoVC = [[MainCourseInfoViewController alloc]init];
        mainCourseInfoVC.hand_id = [[self.searchModel.course_data objectAtIndex:indexPath.item] objectForKey:@"hand_id"];
        [self.navigationController pushViewController:mainCourseInfoVC animated:YES];
        [mainCourseInfoVC release];
        
    }
    if (indexPath.section == 1) {
        UsersDetailViewController *usersDetailVC = [[UsersDetailViewController alloc]init];
        usersDetailVC.useridStr = [[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"uid"];
        usersDetailVC.avatarStr = [[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"avatar"];
        usersDetailVC.nick_nameStr = [[self.searchModel.user_data objectAtIndex:indexPath.item] objectForKey:@"uname"];
        [self.navigationController pushViewController:usersDetailVC animated:YES];
        [usersDetailVC release];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
