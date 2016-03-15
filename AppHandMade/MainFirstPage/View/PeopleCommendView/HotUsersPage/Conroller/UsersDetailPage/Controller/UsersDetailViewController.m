//
//  UsersDetailViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UsersDetailViewController.h"
#import "UsersDetailModel.h"
#import "UsersContentCell.h"
#import "UsersHostCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "MainCourseInfoViewController.h"
#import "CollectModel.h"
#import "DataBaseHandle.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface UsersDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UsersDetailModel *usersDetailModel;
@property (nonatomic, retain) CollectModel *collectModel;
//@property (nonatomic, assign) BOOL flag;
@property (nonatomic, retain) UIButton *rightButton;
@end

@implementation UsersDetailViewController
- (void)dealloc
{
    [_useridStr release];
    [_nick_nameStr release];
    [_avatarStr release];
    
    [_tableView release];
    [_usersDetailModel release];
    
    [_collectModel release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.collectModel = [[CollectModel alloc]init];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.useridStr, @"userId", self.nick_nameStr, @"userName", self.avatarStr, @"faceImage", nil];
    [self.collectModel setValuesForKeysWithDictionary:dic];
    
    NSLog(@"%@", self.collectModel.userId);
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 50*Screen_W, 50*Screen_H);
    [self.rightButton setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateSelected];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    [self.rightButton addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[DataBaseHandle sharedDataBase] openDB];
    [[DataBaseHandle sharedDataBase] createTable];
    NSMutableArray *arr = [[DataBaseHandle sharedDataBase] selectCollectWithName:self.collectModel.userName];
    
    if (arr.count != 0) {
        self.rightButton.selected = YES;
    } else {
        self.rightButton.selected = NO;// 空心
    }
  
}

- (void)rightBarButtonAction:(UIButton *)item
{
    
    item.selected = !item.selected;
    if (item.selected == YES) {
        
        [[DataBaseHandle sharedDataBase] insertCollect:self.collectModel];
        
    }else{
        
        [[DataBaseHandle sharedDataBase] deleteCollectWithName:self.collectModel.userName];
        
    }
}




- (void)handleData
{
    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=User&a=myCourse&uid=%@", self.useridStr];
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        self.usersDetailModel = [[UsersDetailModel alloc]init];
        [self.usersDetailModel setValuesForKeysWithDictionary:dic];
        [_usersDetailModel release];

        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = secondColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UsersHostCell class] forCellReuseIdentifier:@"usersHostCell"];
    [self.tableView registerClass:[UsersContentCell class] forCellReuseIdentifier:@"usersContentCell"];
    
    [self.view addSubview:self.tableView];
    [_tableView release];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180*Screen_H;
    }
    else
    {
        return (self.usersDetailModel.list.count + 1)/2*(240)+60;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UsersHostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usersHostCell"];
        cell.hostImageView.image = [UIImage imageNamed:@"back_mohu"];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatarStr]];
        cell.nameLabel.text = [NSString stringWithFormat:@"达人: %@", self.nick_nameStr];
        return cell;
    }
    else
    {
        UsersContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usersContentCell"];
        
        cell.list = self.usersDetailModel.list;
        [cell.collectionView reloadData];
        
        void(^usersContentBlock)(void) = ^(void){
            
            MainCourseInfoViewController *mainCourseInfoVC = [[MainCourseInfoViewController alloc]init];
            [self.navigationController pushViewController:mainCourseInfoVC animated:YES];
            mainCourseInfoVC.hand_id = cell.hand_idStr;
            [mainCourseInfoVC release];
        
        };
        cell.usersContentBlock = usersContentBlock;
        
        return cell;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"达人主页";
    [self handleData];
    [self createTableView];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        self.tableView.backgroundColor = nightColor;
    }

}
- (void)changeColor:(NSNotification *)notification
{
    self.tableView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.tableView.backgroundColor = secondColor;
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
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
