//
//  NewActivityViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "NewActivityViewController.h"
#import "NewActivityModel.h"
#import "NewActivityCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ActivityDetailViewController.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface NewActivityViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NewActivityModel *activityModel;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) int num;

@end

@implementation NewActivityViewController
- (void)dealloc
{
    [_tableView release];
    [_activityModel release];
    [_array release];
    [super dealloc];
}

- (void)handleData
{
    NSString *str0 = @"http://m.shougongke.com/index.php?&c=Course&a=activityList";
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"++++%@",responseObject);
        self.array = [NSMutableArray array];
        self.activityModel = [[NewActivityModel alloc]init];
        [self.activityModel setValuesForKeysWithDictionary:responseObject];
        
        for (NSMutableDictionary *dic in self.activityModel.data) {
            [self.array addObject:dic];
        }
//        NSLog(@"----%@",self.activityModel.data);
        [_activityModel release];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.backgroundColor = secondColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[NewActivityCell class] forCellReuseIdentifier:@"newActivityCell"];
    
    [self.view addSubview:self.tableView];
    [_tableView release];
    
    
    // refresh
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction:)];
    self.tableView.mj_header = header;
    [header beginRefreshing];
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerAction:)];
    self.tableView.mj_footer = footer;
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
    [self.tableView.mj_header endRefreshing];
    
    
}
/** 上拉加载数据 */
- (void)footerAction:(id)sender
{
    self.num += 10;
    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=activityList&id=%d", self.num];
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.activityModel = [[NewActivityModel alloc]init];
        [self.activityModel setValuesForKeysWithDictionary:responseObject];
        for (NSMutableDictionary *dic in self.activityModel.data) {
            [self.array addObject:dic];
        }
        // 重要部分别忘 加回原model
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObject:self.array forKey:@"data"];
        [self.activityModel setValuesForKeysWithDictionary:dataDic];

        [_activityModel release];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215*Screen_H;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newActivityCell"];
    cell.backgroundColor = secondColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[self.activityModel.data[indexPath.item] objectForKey:@"m_logo"]]];
    cell.nameLabel.text = [self.activityModel.data[indexPath.item] objectForKey:@"c_name"];
    cell.timeLabel.text = [NSString stringWithFormat:@"征集作品时间:%@",[self.activityModel.data[indexPath.item] objectForKey:@"c_time"]];
    if ([[self.activityModel.data[indexPath.item] objectForKey:@"c_status"] isEqualToString:@"2"]) {
        cell.statusLabel.text = @"已结束";
    } else {
        cell.statusLabel.text = @"进行中";
    }
                           
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]init];
    [self.navigationController pushViewController:activityDetailVC animated:YES];
    activityDetailVC.c_idStr = [self.activityModel.data[indexPath.item] objectForKey:@"c_id"];
    [activityDetailVC release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self handleData];
    [self createTableView];
    self.title = @"最新活动";
    
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
