//
//  MainViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "MainViewController.h"
#import "CourseSortCell.h"
#import "HandMadeTopicCell.h"
#import "HotCourseCell.h"
#import "PeopleCommendCell.h"
#import "PeopleLookCell.h"
#import "AFNetWorkTool.h"
#import "MainModel.h"
#import "UIImageView+WebCache.h"
#import "HotCourseCell.h"
#import "CarouselView.h"
#import "MJRefresh.h"
#import "CourseViewController.h"
#import "NewActivityViewController.h"
#import "HotUsersViewController.h"
#import "SubjectHandMadeViewController.h"
#import "MainCourseInfoViewController.h"
#import "SearchViewController.h"
#import "HeaderBase.h"
#import "AFNetworking.h"


#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define wheel_H 160
#define CourseSortCell_H 231
#define PeopleLookCell_H 385
#define PeopleCommendCell_H 280
#define HandMadeTopicCell_H 240



@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) MainModel *mainModel;
@property (nonatomic, retain) NSMutableArray *picStrArr;

@end

@implementation MainViewController
- (void)dealloc
{
    [_tableView release];
    [_array release];
    [_mainModel release];
    [_picStrArr release];
    [super dealloc];
}
/** 判断网络 */
- (void)net
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    
    // 检查网络状态管理者 是单例
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    // 如果要检测网络状态的变化, 必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例, 网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前网络状态不佳，请检查网络" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //创建action对象
            UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            //alert添加action对象
            [alert addAction:actionConfirm];
            //推出alert（模态推出）
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
        if (status == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前网络为3G网络" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //创建action对象
            UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            //alert添加action对象
            [alert addAction:actionConfirm];
            //推出alert（模态推出）
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
        if (status == 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前网络为WIFI" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //创建action对象
            UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            //alert添加action对象
            [alert addAction:actionConfirm];
            //推出alert（模态推出）
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
        
    }];
    [netWorkManager stopMonitoring];

}
/** 主页网络数据请求 */
- (void)handleData
{
    NSString *str = @"http://m.shougongke.com/index.php?&c=index&a=indexnew&vid=12";
    [AFNetWorkTool getUrlString:str body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 主页model数据
        self.array = [NSMutableArray array];
//        NSLog(@"-----%@", responseObject);
        NSMutableDictionary *dataDic = responseObject[@"data"];
        self.mainModel = [[MainModel alloc]init];
        [self.mainModel setValuesForKeysWithDictionary:dataDic];
        [self.array addObject:self.mainModel];
//        NSLog(@"=====%@", self.mainModel.gcate);
        
        // 轮播图数据
        self.picStrArr = [NSMutableArray array];
        for (NSMutableDictionary *dic in self.mainModel.slide) {
            NSString *picStr = dic[@"host_pic"];
            [self.picStrArr addObject:picStr];
        }
        
        [self handleCarousel];
        
        [_mainModel release];
        [self.tableView reloadData];
                
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
/** 创建tableView */
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.backgroundColor = secondColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 定义tableHeaderView
    UIView *carouselView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, wheel_H * Screen_H)];
    carouselView.backgroundColor = [UIColor colorWithRed:0.4445 green:0.5832 blue:0.608 alpha:0.07];
    self.tableView.tableHeaderView = carouselView;
    [carouselView release];
    
    
    
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[CourseSortCell class] forCellReuseIdentifier:@"courseSort"];
    [self.tableView registerClass:[HandMadeTopicCell class] forCellReuseIdentifier:@"handMadeTopic"];
    [self.tableView registerClass:[HotCourseCell class] forCellReuseIdentifier:@"hotCourse"];
    [self.tableView registerClass:[PeopleCommendCell class] forCellReuseIdentifier:@"peopleCommend"];
    [self.tableView registerClass:[PeopleLookCell class] forCellReuseIdentifier:@"peopleLook"];
    
    
    [self.view addSubview:self.tableView];
    [_tableView release];
    
    // 下拉刷新
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction:)];
    self.tableView.mj_header = header;
    [header beginRefreshing];
    
    
}
- (void)headerAction:(id)sender
{
    [self handleData];
    // 结束刷新状态
    [self.tableView.mj_header endRefreshing];
    
}

/** 定义tableView的section数目 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
/** 定义row数目 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
/** 定义tableViewCell每行行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CourseSortCell_H * Screen_H;
    }
    else if(indexPath.section == 1)
    {
        return PeopleLookCell_H * Screen_H;
    }
    else if (indexPath.section == 2)
    {
        return PeopleCommendCell_H * Screen_H;
    }
    else if (indexPath.section == 3)
    {
        return HandMadeTopicCell_H * Screen_H;
    }
    else if(indexPath.section == 4)
    {
        return self.mainModel.course.count / 2  * (262*Screen_H) + 44;
    }
    return 0;

}
/** 主页tableView */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 教程分类 */
    if (indexPath.section == 0) {
        
        CourseSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseSort"];
//        cell.backgroundColor = [UIColor orangeColor];
        cell.gcateArray = self.mainModel.gcate;
//        NSLog(@"!!!!!!!%@", cell.gcateArray);
        
        [cell.collectionView reloadData];
        
        // courseBlock块 向courseVC传数据
        void(^courseBlock)(void) = ^(void) {
            CourseViewController *courseVC = [[CourseViewController alloc]init];
            [self.navigationController pushViewController:courseVC animated:YES];
            
            courseVC.nameStr = cell.nameStr;
            courseVC.timeStr = cell.timeStr;
            courseVC.orderStr = cell.orderStr;
            
            courseVC.cate_idStr = cell.cate_idStr;
            courseVC.pub_timeStr = cell.pub_timeStr;
            courseVC.order_Str = cell.order_Str;
            
            [courseVC release];
        };
        cell.courseBlock = courseBlock;
        
        return cell;
    }
    /** 大家都在看 */
    if (indexPath.section == 1) {
        
        PeopleLookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peopleLook"];
        cell.backgroundColor = [UIColor grayColor];
        cell.relationsDic = self.mainModel.relations;
//        NSLog(@"!!!!!%@", cell.relationsDic);
        
        // newActivityBlock
        void (^newActivityBlock)(void) = ^(void) {
            NewActivityViewController *newActivityVC = [[NewActivityViewController alloc]init];
            [self.navigationController pushViewController:newActivityVC animated:YES];
            [newActivityVC release];
        };
        cell.newActivityBlock = newActivityBlock;
        
        // 热门材料包block
        void(^hotMaterialBlock)(void) = ^(void) {
            CourseViewController *courseVC = [[CourseViewController alloc]init];
            [self.navigationController pushViewController:courseVC animated:YES];
            
            courseVC.nameStr = cell.nameStr;
            courseVC.timeStr = cell.timeStr;
            courseVC.orderStr = cell.orderStr;
            
            courseVC.cate_idStr = cell.cate_idStr;
            courseVC.pub_timeStr = cell.pub_timeStr;
            courseVC.order_Str = cell.order_Str;
            
            [courseVC release];
        };
        cell.hotMaterialBlock = hotMaterialBlock;
        // 精选手工block
        void(^bestHandeMadeBlock)(void) = ^(void) {
            CourseViewController *courseVC = [[CourseViewController alloc]init];
            [self.navigationController pushViewController:courseVC animated:YES];
            
            courseVC.nameStr = cell.nameStr;
            courseVC.timeStr = cell.timeStr;
            courseVC.orderStr = cell.orderStr;
            
            courseVC.cate_idStr = cell.cate_idStr;
            courseVC.pub_timeStr = cell.pub_timeStr;
            courseVC.order_Str = cell.order_Str;
            
            [courseVC release];
        };
        cell.bestHandeMadeBlock = bestHandeMadeBlock;

        
        [cell.collectionView reloadData];
        return cell;
    }
    /** 达人推荐 */
    if (indexPath.section == 2) {
        
        PeopleCommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peopleCommend"];
//        cell.backgroundColor = [UIColor yellowColor];
//        NSLog(@"!!!!%@", self.mainModel.daren);
        
//        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.mainModel.daren[@"bg_image"]]];
        cell.bgImageView.image = [UIImage imageNamed:@"hand"];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.mainModel.daren[@"avatar"]]];
        cell.userName.text = self.mainModel.daren[@"uname"];
        cell.userLocation.text = self.mainModel.daren[@"region"];
        cell.infoLabel.text = [NSString stringWithFormat:@"教程·%@ 粉丝·%@ 手工圈·%@", self.mainModel.daren[@"coursecount"], self.mainModel.daren[@"fen_num"], self.mainModel.daren[@"circle_count"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    /** 手工专题 */
    if (indexPath.section == 3) {
        HandMadeTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"handMadeTopic"];
//        cell.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:[[[self.mainModel.topic lastObject] objectForKey:@"pic"] objectAtIndex:0]]];
        [cell.rightImageView1 sd_setImageWithURL:[NSURL URLWithString:[[[self.mainModel.topic lastObject] objectForKey:@"pic"] objectAtIndex:1]]];
        [cell.rightImageView2 sd_setImageWithURL:[NSURL URLWithString:[[[self.mainModel.topic lastObject] objectForKey:@"pic"] objectAtIndex:2]]];
        [cell.rightImageView3 sd_setImageWithURL:[NSURL URLWithString:[[[self.mainModel.topic lastObject] objectForKey:@"pic"] objectAtIndex:3]]];
        [cell.rightImageView4 sd_setImageWithURL:[NSURL URLWithString:[[[self.mainModel.topic lastObject] objectForKey:@"pic"] objectAtIndex:4]]];
        cell.infoLabel.text = [[self.mainModel.topic lastObject] objectForKey:@"subject"];
        return cell;
    }
    /** 热门教程 */
    if (indexPath.section == 4) {
        HotCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCourse"];
        cell.backgroundColor = [UIColor blueColor];
        cell.courseArray = self.mainModel.course;
//        NSLog(@"!!!%@", cell.courseArray);
        
        // hotCourseBlock
        void(^hotCourseBlock)(void) = ^(void) {
            MainCourseInfoViewController *mainCourseInfoVC = [[MainCourseInfoViewController alloc]init];
            [self.navigationController pushViewController:mainCourseInfoVC animated:YES];
            [mainCourseInfoVC release];
            mainCourseInfoVC.hand_id = cell.hand_id;
        };
        cell.hotCourseBlock = hotCourseBlock;
        
        [cell.collectionView reloadData];
        return cell;
    }
    
   
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.backgroundColor = [UIColor blackColor];
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        HotUsersViewController *hotUsersVC = [[HotUsersViewController alloc]init];
        [self.navigationController pushViewController:hotUsersVC animated:YES];
        [hotUsersVC release];
    }
    if (indexPath.section == 3) {

        SubjectHandMadeViewController *subjectHandMadeVC = [[SubjectHandMadeViewController alloc]init];
        [self.navigationController pushViewController:subjectHandMadeVC animated:YES];
        [subjectHandMadeVC release];
    }
}
/** 处理轮播图部分 */
- (void)handleCarousel
{
//    NSLog(@"+++%@", self.picStrArr);
    CarouselView *carouse = [CarouselView carouselViewWithArray:self.picStrArr carouselFrame:CGRectMake(0, 0, self.view.frame.size.width, wheel_H * Screen_H) pageFrame:CGRectMake(self.view.frame.size.width / 2.3, (wheel_H - 10)* Screen_H, self.view.frame.size.width / 10, 5)];
    [self.tableView addSubview:carouse];
}


/** 搜索页 */
- (void)searchButtonAction:(UIBarButtonItem *)item
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self net];
    [self handleData];
    
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonAction:)]autorelease];
    
    [self createTableView];
    
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        self.view.backgroundColor = nightColor;
        self.tableView.backgroundColor = nightColor;
    }

}
- (void)changeColor:(NSNotification *)notification
{
    self.view.backgroundColor = nightColor;
    self.tableView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
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
