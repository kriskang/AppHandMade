//
//  SubjectHandMadeViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/20.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SubjectHandMadeViewController.h"
#import "SubjectHandMadeModel.h"
#import "SubjectHandMadeCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "SubjectPicListViewController.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface SubjectHandMadeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) SubjectHandMadeModel *subjectHandMadeModel;
@property (nonatomic, retain) NSMutableArray *array;

@end

@implementation SubjectHandMadeViewController
- (void)dealloc
{
    [_tableView release];
    [_subjectHandMadeModel release];
    [_array release];
    [super dealloc];
}
- (void)handleData
{
    NSString *str0 = @"http://m.shougongke.com/index.php?&c=Course&a=topic&";
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.subjectHandMadeModel = [[SubjectHandMadeModel alloc]init];
        NSMutableDictionary *dataDic = responseObject[@"data"];
        [self.subjectHandMadeModel setValuesForKeysWithDictionary:dataDic];
        [_subjectHandMadeModel release];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = secondColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SubjectHandMadeCell class] forCellReuseIdentifier:@"subjectHandMadeCell"];
    
    [self.view addSubview:self.tableView];
    [_tableView release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subjectHandMadeModel.list.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectHandMadeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subjectHandMadeCell"];
    cell.backgroundColor = secondColor;
    cell.titleLabel.text = [self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"subject"];
    [cell.rightImageView sd_setImageWithURL:[NSURL URLWithString:[[self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"pic"] firstObject]]];
    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[[self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"pic"] objectAtIndex:1]]];
    [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[[self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"pic"] objectAtIndex:2]]];
    [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:[[self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"pic"] objectAtIndex:3]]];
    [cell.imageView4 sd_setImageWithURL:[NSURL URLWithString:[[self.subjectHandMadeModel.list[indexPath.item] objectForKey:@"pic"] objectAtIndex:4]]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250*Screen_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SubjectPicListViewController *subjectPicListVC = [[SubjectPicListViewController alloc]init];
    [self.navigationController pushViewController:subjectPicListVC animated:YES];
    subjectPicListVC.idStr = [[self.subjectHandMadeModel.list objectAtIndex:indexPath.item]objectForKey:@"id"];
    [subjectPicListVC release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手工专题";
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
