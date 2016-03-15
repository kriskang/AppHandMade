//
//  HotUsersViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HotUsersViewController.h"
#import "HotUsersModel.h"
#import "HotUsersCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "UsersDetailViewController.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface HotUsersViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) HotUsersModel *hotUsersModel;
@end

@implementation HotUsersViewController
- (void)dealloc
{
    [_tableView release];
    [_array release];
    [_hotUsersModel release];
    [super dealloc];
}
- (void)handleData
{
    NSString *str0 = @"http://m.shougongke.com/index.php?&c=Index&a=daren";
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.array = [NSMutableArray array];
        self.hotUsersModel = [[HotUsersModel alloc]init];
        [self.hotUsersModel setValuesForKeysWithDictionary:responseObject];
        [self.array addObject:self.hotUsersModel];
        [_hotUsersModel release];
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
   
    [self.tableView registerClass:[HotUsersCell class] forCellReuseIdentifier:@"hotUsersCell"];
    
    [self.view addSubview:self.tableView];
    [_tableView release];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotUsersModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotUsersCell"];
    cell.backgroundColor = secondColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[self.hotUsersModel.data[indexPath.item] objectForKey:@"avatar"]]];
    cell.nameLabel.text = [self.hotUsersModel.data[indexPath.item] objectForKey:@"nick_name"];
    cell.infoLabel.text = [NSString stringWithFormat:@"%@个教程 | %@条手工圈",[[self.hotUsersModel.data objectAtIndex:indexPath.item]objectForKey:@"course_count"], [[self.hotUsersModel.data objectAtIndex:indexPath.item]objectForKey:@"opus_count"]];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:[[[[self.hotUsersModel.data objectAtIndex:indexPath.item] objectForKey:@"list"] firstObject]objectForKey:@"host_pic"]]];
    
    if ([[[self.hotUsersModel.data objectAtIndex:indexPath.item] objectForKey:@"list"] count] >= 2) {
        [cell.centerImageView sd_setImageWithURL:[NSURL URLWithString:[[[[self.hotUsersModel.data objectAtIndex:indexPath.item] objectForKey:@"list"] objectAtIndex:1]objectForKey:@"host_pic"]]];
    }
    
    if([[[self.hotUsersModel.data objectAtIndex:indexPath.item] objectForKey:@"list"] count] == 3) {
        [cell.rightImageView sd_setImageWithURL:[NSURL URLWithString:[[[[self.hotUsersModel.data objectAtIndex:indexPath.item] objectForKey:@"list"] objectAtIndex:2]objectForKey:@"host_pic"]]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210*Screen_H;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UsersDetailViewController *usersDetailVC = [[UsersDetailViewController alloc]init];
    [self.navigationController pushViewController:usersDetailVC animated:YES];
    usersDetailVC.useridStr = [self.hotUsersModel.data[indexPath.item] objectForKey:@"user_id"];
    usersDetailVC.nick_nameStr = [self.hotUsersModel.data[indexPath.item] objectForKey:@"nick_name"];
    usersDetailVC.avatarStr = [self.hotUsersModel.data[indexPath.item] objectForKey:@"avatar"];
    [usersDetailVC release];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self handleData];
    [self createTableView];
    self.title = @"达人推荐";
    
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
