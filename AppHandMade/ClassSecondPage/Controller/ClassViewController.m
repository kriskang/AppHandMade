//
//  ClassViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassCell.h"
#import "AFNetWorkTool.h"
#import "ClassModel.h"
#import "HeaderBase.h"


//#import "ClassDetailViewController.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface ClassViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) ClassModel *classModel;
@end

@implementation ClassViewController
- (void)dealloc
{
    [_tableView release];
    [_array release];
    [_classModel release];
    [super dealloc];
}

- (void)handleData
{
    
    NSString *url = @"http://yuntuapi.amap.com/datasearch/local?tableid=550fa56ce4b050797967f047&city=全国&keywords=&filter=city_name:北京&sortrule=sort_index:0&limit=20&page=1&key=55f0eadf1e00f8defca60c0f4bb1e700&ts=1448246122916&scode=36de2e4b9bde766967fe51e6d766f14f";
    [AFNetWorkTool getUrlString:url body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
        
        self.array = [NSMutableArray array];
        NSMutableArray *arr = responseObject[@"datas"];
        for (NSMutableDictionary *dic in arr) {
            ClassModel *classModel = [[ClassModel alloc] init];
            [classModel setValuesForKeysWithDictionary:dic];
            [self.array addObject:classModel];
            [classModel release];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


/** 创建tableView */
- (void)createTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = secondColor;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ClassCell class] forCellReuseIdentifier:@"classCell"];
    [_tableView release];
}

/** 设置tableView内section的行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

/** 返回每个cell高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210.0*Screen_H;
}

/** 设置tableViewCell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ClassModel *model = self.array[indexPath.row];
//    NSLog(@"!!! %@", model.subject);
#pragma mark - 为什么不用给cell的model创建空间
    cell.model = model;
//    cell.model = self.array[indexPath.row];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ClassDetailViewController *classDetailVC =  [[ClassDetailViewController alloc]init];
//    [self.navigationController pushViewController:classDetailVC animated:YES];
//    ClassModel *model = self.array[indexPath.row];
//    classDetailVC.cidStr = model.cid;
//    NSLog(@"%@",classDetailVC.cidStr);
//    [classDetailVC release];
//    
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [self handleData];
    
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
