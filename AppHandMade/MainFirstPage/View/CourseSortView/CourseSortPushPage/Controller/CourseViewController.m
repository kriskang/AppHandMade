//
//  CourseViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/13.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseViewController.h"
#import "RightBtnView.h"
#import "CenterBtnView.h"
#import "LeftBtnView.h"
#import "CourseColCell.h"
#import "AFNetWorkTool.h"
#import "CourseModel.h"
#import "UIColor+ColorChange.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MainCourseInfoViewController.h"
#import "HeaderBase.h"


#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface CourseViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) UIButton *rightBtn;
@property (nonatomic, retain) UIButton *centerBtn;
@property (nonatomic, retain) UIButton *leftBtn;

@property (nonatomic, retain) RightBtnView *rightBtnView;
@property (nonatomic, retain) CenterBtnView *centerBtnView;
@property (nonatomic, retain) LeftBtnView *leftBtnView;

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) CourseModel *courseModel;

@property (nonatomic, assign) int num;

@property (nonatomic, retain) MBProgressHUD *HUD;

// button点击次数
@property (nonatomic, assign) int leftClickNum;
@property (nonatomic, assign) int rightClickNum;
@property (nonatomic, assign) int centerClickNum;

@end

@implementation CourseViewController
- (void)dealloc
{

    [_nameStr release];
    [_timeStr release];
    [_orderStr release];
    [_cate_idStr release];
    [_pub_timeStr release];
    [_order_Str release];
    
    [_rightBtn release];
    [_leftBtn release];
    [_centerBtn release];
    
    [_rightBtnView release];
    [_leftBtnView release];
    [_centerBtnView release];
    
    [_collectionView release];
    [_flowLayout release];
    [_array release];
    
    [_courseModel release];
    
    [_HUD release];
    
    [super dealloc];
}

/** 当view将要消失时 移除HUD */
- (void)viewWillDisappear:(BOOL)animated
{
    [self.HUD removeFromSuperview];
}

/** 数据处理 */
- (void)handleData
{
    
    // 数据加载 progressHUB
    
    self.HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    //HUD.delegate = self;
    self.HUD.labelText = @"数据加载中...";
    [self.HUD hide:YES];

    
    

    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=newCourseList%@&order=%@&pub_time=%@", self.cate_idStr, self.order_Str, self.pub_timeStr];
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"----%@", responseObject);
        self.courseModel = [[CourseModel alloc]init];
        [self.courseModel setValuesForKeysWithDictionary:responseObject];
        self.array = [NSMutableArray array];
        for (NSMutableDictionary *dic in self.courseModel.data) {
            [self.array addObject:dic];
        }
        [_courseModel release];
//        NSLog(@"****%@",self.courseModel.data);
//        NSLog(@"****%@", self.array);
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"111111%@", error);
    }];
}

/** 创建3个头按钮*/
- (void)createTopView
{
    // 按钮
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 65, (self.view.bounds.size.width-6) / 3, 35);
    [self.leftBtn setTitle:[self.nameStr stringByAppendingFormat:@"﹀"] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:12*Screen_H];
    self.leftBtn.backgroundColor = [UIColor whiteColor];
    self.leftBtn.tintColor = [UIColor blackColor];
    [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightBtn.frame = CGRectMake((self.view.bounds.size.width-6)/3*2+6, 65, (self.view.bounds.size.width-6)/3, 35);
    [self.rightBtn setTitle:[self.orderStr stringByAppendingFormat:@"﹀"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12*Screen_H];
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    self.rightBtn.tintColor = [UIColor blackColor];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBtn];

    self.centerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.centerBtn.frame = CGRectMake((self.view.bounds.size.width-6)/3+3, 65, (self.view.bounds.size.width-6)/3, 35);
    [self.centerBtn setTitle:[self.timeStr stringByAppendingFormat:@"﹀"] forState:UIControlStateNormal];
    self.centerBtn.titleLabel.font = [UIFont systemFontOfSize:12*Screen_H];
    self.centerBtn.backgroundColor = [UIColor whiteColor];
    self.centerBtn.tintColor = [UIColor blackColor];
    [self.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.centerBtn];

    // 点击视图
    self.leftBtnView = [[LeftBtnView alloc]initWithFrame:CGRectMake(0, 100, 375*Screen_W, 228*Screen_H)];
    [_leftBtnView release];
    self.centerBtnView = [[CenterBtnView alloc]initWithFrame:CGRectMake(0, 100, 375*Screen_W, 140*Screen_H)];
    [_centerBtnView release];
    self.rightBtnView = [[RightBtnView alloc]initWithFrame:CGRectMake(0, 100, 375*Screen_W, 270*Screen_H)];
    [_rightBtnView release];
    
    // 创建collectionView
    [self createCollectionView];
    
    // refresh
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction:)];
    self.collectionView.mj_header = header;
    [header beginRefreshing];
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerAction:)];
    self.collectionView.mj_footer = footer;
    [footer beginRefreshing];

}
/** 下拉刷新 */
- (void)headerAction:(id)sender
{
    // 移除数组里全部数据
    [self.array removeAllObjects];
    // 重新网络请求 加载数据
    [self handleData];
    
    //结束刷新状态
    [self.collectionView.mj_header endRefreshing];

    
}
/** 上拉加载数据 */
- (void)footerAction:(id)sender
{
    self.num += 20;
    
//    NSString *str = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=newCourseList%@&last_id=%d&order=%@", self.idStr, self.num, self.lastStr];
    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=newCourseList%@&last_id=%d&order=%@&pub_time=%@", self.cate_idStr, self.num, self.order_Str, self.pub_timeStr];
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *arr = [responseObject objectForKey:@"data"];
        self.courseModel = [[CourseModel alloc]init];
        for (NSDictionary *dic in arr) {
            [self.array addObject:dic];
        }
        // 数据的大字典
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObject:self.array forKey:@"data"];
        [self.courseModel setValuesForKeysWithDictionary:dataDic];
        [_courseModel release];
        [self.collectionView.mj_footer endRefreshing];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"222222%@", error);
    }];
    
}

/** 左按钮点击 */
- (void)leftBtnClick:(UIButton *)btn
{
    self.leftClickNum++;
   /** 判断点击次数的*/
    if (self.leftClickNum % 2 == 1) {
//        NSLog(@"OPEN");
        [self.leftBtn setTitle:[self.nameStr stringByAppendingFormat:@"︿"] forState:UIControlStateNormal];
        self.leftBtn.tintColor = [UIColor redColor];
        self.collectionView.userInteractionEnabled = NO;
        [self.view addSubview:self.leftBtnView];
        
        // leftBtnBlock
        void (^leftBtnBlock)(NSString *nameStr,NSString *cate_idStr) = ^(NSString *nameStr, NSString *cate_idStr) {
            
            self.nameStr = nameStr;
            [btn setTitle:[self.nameStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
            btn.tintColor = [UIColor blackColor];
            
            self.cate_idStr = cate_idStr;
            self.num = 0;
            [self handleData];
            self.collectionView.userInteractionEnabled = YES;
            [self.leftBtnView removeFromSuperview];
            self.leftClickNum = 0;
        };
        
        self.leftBtnView.leftBtnBlock = leftBtnBlock;
        
    } else {
//        NSLog(@"CLOSE");
        [self.leftBtn setTitle:[self.nameStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
        self.leftBtn.tintColor = [UIColor blackColor];
        self.collectionView.userInteractionEnabled = YES;
        [self.leftBtnView removeFromSuperview];
    }
    
    // 中 归到初始状态
    self.centerClickNum = 0;
    [self.centerBtnView removeFromSuperview];
    self.centerBtn.tintColor = [UIColor blackColor];
    [self.centerBtn setTitle:[self.timeStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
    // 右 归到初始状态
    self.rightClickNum = 0;
    [self.rightBtnView removeFromSuperview];
    self.rightBtn.tintColor = [UIColor blackColor];
    [self.rightBtn setTitle:[self.orderStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
    
}
/** 中按钮点击 */
- (void)centerBtnClick:(UIButton *)btn
{
    self.centerClickNum++;
    /** 判断点击次数的*/
    if (self.centerClickNum % 2 == 1) {
//        NSLog(@"OPEN");
        [self.centerBtn setTitle:[self.timeStr stringByAppendingFormat:@"︿"] forState:UIControlStateNormal];
        self.centerBtn.tintColor = [UIColor redColor];
        self.collectionView.userInteractionEnabled = NO;
        [self.view addSubview:self.centerBtnView];
        
        // centerBtnBlock
        void (^centerBtnBlock)(NSString *timeStr, NSString *pub_timeStr) = ^(NSString *timeStr, NSString *pub_timeStr) {
            self.timeStr = timeStr;
            [btn setTitle:[self.timeStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
            btn.tintColor = [UIColor blackColor];
            
            self.pub_timeStr = pub_timeStr;
            self.num = 0;
            [self handleData];
            self.collectionView.userInteractionEnabled = YES;
            [self.centerBtnView removeFromSuperview];
            self.centerClickNum = 0;
        };
        self.centerBtnView.centerBtnBlock = centerBtnBlock;
        
    } else {
//        NSLog(@"CLOSE");
        [self.centerBtn setTitle:[self.timeStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
        self.centerBtn.tintColor = [UIColor blackColor];
        self.collectionView.userInteractionEnabled = YES;
        [self.centerBtnView removeFromSuperview];
    }
    // 左 归到初始状态
    self.leftClickNum = 0;
    [self.leftBtnView removeFromSuperview];
    self.leftBtn.tintColor = [UIColor blackColor];
    [self.leftBtn setTitle:[self.nameStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
    
    // 右 归到初始状态
    self.rightClickNum = 0;
    [self.rightBtnView removeFromSuperview];
    self.rightBtn.tintColor = [UIColor blackColor];
    [self.rightBtn setTitle:[self.orderStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
    

    
}
/** 右按钮点击 */
- (void)rightBtnClick:(UIButton *)btn
{
    self.rightClickNum++;
    /** 判断点击次数的 */
    if (self.rightClickNum % 2 == 1) {
//        NSLog(@"OPEN");
        [self.rightBtn setTitle:[self.orderStr stringByAppendingString:@"︿"] forState:UIControlStateNormal];
        self.rightBtn.tintColor = [UIColor redColor];
        self.collectionView.userInteractionEnabled = NO;
        [self.view addSubview:self.rightBtnView];
        
        // rightBtnBlock
        void (^rightBtnBlock)(NSString *orderStr, NSString *order_Str) = ^(NSString *orderStr, NSString *order_Str) {
            self.orderStr = orderStr;
            [btn setTitle:[self.orderStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
            btn.tintColor = [UIColor blackColor];
            
            self.order_Str = order_Str;
            self.num = 0;
            [self handleData];
            [self.rightBtnView removeFromSuperview];
            self.collectionView.userInteractionEnabled = YES;
            self.rightClickNum = 0;
        };
        self.rightBtnView.rightBtnBlock = rightBtnBlock;
        
    } else {
//        NSLog(@"CLOSE");
        [self.rightBtn setTitle:[self.orderStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
        self.rightBtn.tintColor = [UIColor blackColor];
        self.collectionView.userInteractionEnabled = YES;
        [self.rightBtnView removeFromSuperview];
    }
    
    // 左 归到初始状态
    self.leftClickNum = 0;
    [self.leftBtnView removeFromSuperview];
    self.leftBtn.tintColor = [UIColor blackColor];
    [self.leftBtn setTitle:[self.nameStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];
    
    // 中 归到初始状态
    self.centerClickNum = 0;
    [self.centerBtnView removeFromSuperview];
    self.centerBtn.tintColor = [UIColor blackColor];
    [self.centerBtn setTitle:[self.timeStr stringByAppendingString:@"﹀"] forState:UIControlStateNormal];

}

/** 创建collectionView */
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_flowLayout setItemSize:CGSizeMake(165*Screen_W, 250*Screen_H)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(20*Screen_H, 15*Screen_H, 0, 15*Screen_W);
    [_flowLayout release];
    

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height -110- 35*Screen_H) collectionViewLayout:self.flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = secondColor;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CourseColCell class] forCellWithReuseIdentifier:@"courseColCell"];
    
    [self.view addSubview:self.collectionView];
    [_collectionView release];

}
/** 设置item数目 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
/** 重用池cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseColCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;
    cell.backgroundColor = [UIColor colorWithHexString:[self.courseModel.data[indexPath.item] objectForKey:@"bg_color"]];
    
    [cell.hostImageView sd_setImageWithURL:[NSURL URLWithString:[self.courseModel.data[indexPath.item] objectForKey:@"host_pic"]]];
    cell.subjectLabel.text = [self.courseModel.data[indexPath.item] objectForKey:@"subject"];
    cell.userNameLabel.text = [NSString stringWithFormat:@"by %@", [self.courseModel.data[indexPath.item] objectForKey:@"user_name"]];
    cell.infoLabel.text = [NSString stringWithFormat:@"%@人气/%@收藏", [self.courseModel.data[indexPath.item] objectForKey:@"view"], [self.courseModel.data[indexPath.item] objectForKey:@"collect"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCourseInfoViewController *mainCourseInfoVC = [[MainCourseInfoViewController alloc]init];
    [self.navigationController pushViewController:mainCourseInfoVC animated:YES];
    mainCourseInfoVC.hand_id = [self.courseModel.data[indexPath.item] objectForKey:@"hand_id"];
    [mainCourseInfoVC release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = secondColor;
    self.title = @"教程";
    [self handleData];
    [self createTopView];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        self.leftBtn.backgroundColor = nightColorCell;
        self.centerBtn.backgroundColor = nightColorCell;
        self.rightBtn.backgroundColor = nightColorCell;
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.collectionView.backgroundColor = nightColor;
        self.view.backgroundColor = nightColor;

    }

}
- (void)changeColor:(NSNotification *)notification
{
    self.leftBtn.backgroundColor = nightColorCell;
    self.centerBtn.backgroundColor = nightColorCell;
    self.rightBtn.backgroundColor = nightColorCell;
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.collectionView.backgroundColor = nightColor;
    self.view.backgroundColor = nightColor;
    
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.leftBtn.backgroundColor = [UIColor whiteColor];
        self.centerBtn.backgroundColor = [UIColor whiteColor];
        self.rightBtn.backgroundColor = [UIColor whiteColor];
        [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.collectionView.backgroundColor = secondColor;
        self.view.backgroundColor = secondColor;
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
