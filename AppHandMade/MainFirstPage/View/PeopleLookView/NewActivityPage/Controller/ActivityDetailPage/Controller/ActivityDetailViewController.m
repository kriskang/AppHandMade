//
//  ActivityDetailViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityIntroductionCell.h"
#import "NewWorksCell.h"
#import "MostVateCell.h"
#import "AFNetWorkTool.h"
#import "NewWorksModel.h"
#import "MostVateModel.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define btnColor [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:0.878]
@interface ActivityDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) UIButton *leftBtn;
@property (nonatomic, retain) UIButton *centerBtn;
@property (nonatomic, retain) UIButton *rightBtn;

@property (nonatomic, retain) NewWorksModel *nnewWorksModel;
@property (nonatomic, retain) MostVateModel *mostVateModel;

@end

@implementation ActivityDetailViewController
- (void)dealloc
{
    [_c_idStr release];
    
    [_collectionView release];
    [_flowLayout release];
    [_leftBtn release];
    [_centerBtn release];
    [_rightBtn release];
    
    [_nnewWorksModel release];
    [_mostVateModel release];
    
    [super dealloc];
}
- (void)handleData
{
    NSString *str1 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&a=getOpus&cid=%@&order=new", self.c_idStr];
    [AFNetWorkTool getUrlString:str1 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.nnewWorksModel = [[NewWorksModel alloc]init];
        [self.nnewWorksModel setValuesForKeysWithDictionary:responseObject];
        [_nnewWorksModel release];
        [_collectionView reloadData];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    NSString *str2 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&a=getOpus&cid=%@&order=votes", self.c_idStr];
    [AFNetWorkTool getUrlString:str2 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.mostVateModel = [[MostVateModel alloc]init];
        [self.mostVateModel setValuesForKeysWithDictionary:responseObject];
        [_mostVateModel release];
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)createTopView
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(1*Screen_W, 65, 123*Screen_W, 40*Screen_H);
    [self.leftBtn setTitle:@"活动介绍" forState:UIControlStateNormal];
    self.leftBtn.tintColor = [UIColor blackColor];
    self.leftBtn.backgroundColor = btnColor;
    [self.leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.centerBtn.frame = CGRectMake(125*Screen_W, 65, 124*Screen_W, 40*Screen_H);
    [self.centerBtn setTitle:@"最新作品" forState:UIControlStateNormal];
    self.centerBtn.tintColor = [UIColor blackColor];
    self.centerBtn.backgroundColor = [UIColor whiteColor];
    [self.centerBtn addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.centerBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightBtn.frame = CGRectMake(250*Screen_W, 65, 123*Screen_W, 40*Screen_H);
    [self.rightBtn setTitle:@"投票最多" forState:UIControlStateNormal];
    self.rightBtn.tintColor = [UIColor blackColor];
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBtn];

}


- (void)leftButtonAction:(UIButton *)btn
{
    self.leftBtn.backgroundColor = btnColor;
    self.centerBtn.backgroundColor = [UIColor whiteColor];
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor1:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.leftBtn.backgroundColor = [UIColor grayColor];
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = nightColorCell;
    }

}
- (void)changeColor1:(NSNotification *)notification
{
    self.leftBtn.backgroundColor = [UIColor grayColor];
    self.centerBtn.backgroundColor = nightColorCell;
    self.rightBtn.backgroundColor = nightColorCell;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.leftBtn.backgroundColor = btnColor;
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = [UIColor whiteColor];

    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)centerButtonAction:(UIButton *)btn
{
    self.leftBtn.backgroundColor = [UIColor whiteColor];
    self.centerBtn.backgroundColor = btnColor;
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.collectionView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:YES];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor2:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.leftBtn.backgroundColor = nightColorCell;
        self.centerBtn.backgroundColor = [UIColor grayColor];
        self.rightBtn.backgroundColor = nightColorCell;
    }
}
- (void)changeColor2:(NSNotification *)notification
{
    self.leftBtn.backgroundColor = nightColorCell;
    self.centerBtn.backgroundColor = [UIColor grayColor];
    self.rightBtn.backgroundColor = nightColorCell;

    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.leftBtn.backgroundColor = [UIColor whiteColor];
        self.centerBtn.backgroundColor = btnColor;
        self.rightBtn.backgroundColor = [UIColor whiteColor];
        
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)rightButtonAction:(UIButton *)btn
{
    self.leftBtn.backgroundColor = [UIColor whiteColor];
    self.centerBtn.backgroundColor = [UIColor whiteColor];
    self.rightBtn.backgroundColor = btnColor;
    [self.collectionView setContentOffset:CGPointMake(self.view.bounds.size.width * 2, 0) animated:YES];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor3:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.leftBtn.backgroundColor = nightColorCell;
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = [UIColor grayColor];
    }
}

- (void)changeColor3:(NSNotification *)notification
{
    self.leftBtn.backgroundColor = nightColorCell;
    self.centerBtn.backgroundColor = nightColorCell;
    self.rightBtn.backgroundColor = [UIColor grayColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.leftBtn.backgroundColor = [UIColor whiteColor];
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = btnColor;
        
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    NSLog(@"%g",self.view.frame.size.height);
    if (self.view.frame.size.height == 480.0) {
        self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 510*Screen_H - 30);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.minimumLineSpacing = 0;
    } else if (self.view.frame.size.height == 568.0) {
        self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 510*Screen_H - 10);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.minimumLineSpacing = 0;
    } else if (self.view.frame.size.height == 736.0) {
        self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 510*Screen_H + 20);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.minimumLineSpacing = 0;
    }
    else {
        self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 510*Screen_H);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.minimumLineSpacing = 0;
    }
  
   [_flowLayout release];
    
    if (self.view.frame.size.height == 480.0) {
        self. collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65+(40*Screen_H), self.view.bounds.size.width, 510*Screen_H - 30) collectionViewLayout:self.flowLayout];
    } else if (self.view.frame.size.height == 568.0) {
        self. collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65+(40*Screen_H), self.view.bounds.size.width, 510*Screen_H - 10) collectionViewLayout:self.flowLayout];

    } else if (self.view.frame.size.height == 736.0) {
        self. collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65+(40*Screen_H), self.view.bounds.size.width, 510*Screen_H + 20) collectionViewLayout:self.flowLayout];
    } else {
        self. collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65+(40*Screen_H), self.view.bounds.size.width, 510*Screen_H) collectionViewLayout:self.flowLayout];
    }
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[ActivityIntroductionCell class] forCellWithReuseIdentifier:@"activityIntroductionCell"];
    [self.collectionView registerClass:[NewWorksCell class] forCellWithReuseIdentifier:@"newWorksCell"];
    [self.collectionView registerClass:[MostVateCell class] forCellWithReuseIdentifier:@"mostVateCell"];
    
    [_collectionView release];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ActivityIntroductionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"activityIntroductionCell" forIndexPath:indexPath];
        
        // webview
        NSString *str = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&cid=%@", self.c_idStr];
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [cell.webView loadRequest:request];

        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    if (indexPath.section == 1) {
        NewWorksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newWorksCell" forIndexPath:indexPath];
        cell.dataArray = self.nnewWorksModel.data;
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    if (indexPath.section == 2) {
        MostVateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mostVateCell" forIndexPath:indexPath];
        cell.dataArray = self.mostVateModel.data;
        cell.backgroundColor = [UIColor orangeColor];
        return cell;
    }
    return nil;
}

/** btn选中颜色 跟着页面滑动 UIScrollViewDelegate协议方法 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.collectionView.contentOffset.x == 0) {
        self.leftBtn.backgroundColor = btnColor;
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = [UIColor whiteColor];
    }
    else if (self.collectionView.contentOffset.x == self.view.bounds.size.width) {
        self.leftBtn.backgroundColor = [UIColor whiteColor];
        self.centerBtn.backgroundColor = btnColor;
        self.rightBtn.backgroundColor = [UIColor whiteColor];
    }
    else if (self.collectionView.contentOffset.x == self.view.bounds.size.width * 2)
    {
        self.leftBtn.backgroundColor = [UIColor whiteColor];
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = btnColor;
    }
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor0:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        if (self.collectionView.contentOffset.x == 0) {
            self.leftBtn.backgroundColor = [UIColor grayColor];
            self.centerBtn.backgroundColor = nightColorCell;
            self.rightBtn.backgroundColor = nightColorCell;
        }
        else if (self.collectionView.contentOffset.x == self.view.bounds.size.width) {
            self.leftBtn.backgroundColor = nightColorCell;
            self.centerBtn.backgroundColor = [UIColor grayColor];
            self.rightBtn.backgroundColor = nightColorCell;
        }
        else if (self.collectionView.contentOffset.x == self.view.bounds.size.width * 2)
        {
            self.leftBtn.backgroundColor = nightColorCell;
            self.centerBtn.backgroundColor = nightColorCell;
            self.rightBtn.backgroundColor = [UIColor grayColor];
        }
    }
    
}
- (void)changeColor0:(NSNotification *)notification
{
    if (self.collectionView.contentOffset.x == 0) {
        self.leftBtn.backgroundColor = [UIColor grayColor];
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = nightColorCell;
    }
    else if (self.collectionView.contentOffset.x == self.view.bounds.size.width) {
        self.leftBtn.backgroundColor = nightColorCell;
        self.centerBtn.backgroundColor = [UIColor grayColor];
        self.rightBtn.backgroundColor = nightColorCell;
    }
    else if (self.collectionView.contentOffset.x == self.view.bounds.size.width * 2)
    {
        self.leftBtn.backgroundColor = nightColorCell;
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = [UIColor grayColor];
    }
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        if (self.collectionView.contentOffset.x == 0) {
            self.leftBtn.backgroundColor = btnColor;
            self.centerBtn.backgroundColor = [UIColor whiteColor];
            self.rightBtn.backgroundColor = [UIColor whiteColor];
        }
        else if (self.collectionView.contentOffset.x == self.view.bounds.size.width) {
            self.leftBtn.backgroundColor = [UIColor whiteColor];
            self.centerBtn.backgroundColor = btnColor;
            self.rightBtn.backgroundColor = [UIColor whiteColor];
        }
        else if (self.collectionView.contentOffset.x == self.view.bounds.size.width * 2)
        {
            self.leftBtn.backgroundColor = [UIColor whiteColor];
            self.centerBtn.backgroundColor = [UIColor whiteColor];
            self.rightBtn.backgroundColor = btnColor;
        }
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = secondColor;
    self.title = @"活动详情";
    [self handleData];
    [self createTopView];
    [self createCollectionView];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.view.backgroundColor = nightColor;
        self.leftBtn.backgroundColor = [UIColor grayColor];
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = nightColorCell;
    }

}
- (void)changeColor:(NSNotification *)notification
{
    self.view.backgroundColor = nightColor;
    self.leftBtn.backgroundColor = [UIColor grayColor];
    self.centerBtn.backgroundColor = nightColorCell;
    self.rightBtn.backgroundColor = nightColorCell;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.view.backgroundColor = secondColor;
        self.leftBtn.backgroundColor = btnColor;
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = [UIColor whiteColor];
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
