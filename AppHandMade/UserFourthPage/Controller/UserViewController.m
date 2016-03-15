//
//  UserViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UserViewController.h"
#import "UserCell.h"
#import "CollectViewController.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *array;
@end

@implementation UserViewController
- (void)dealloc
{
    [_tableView release];
    [_array release];
    [super dealloc];
}
- (void)createArray
{
    self.array = [NSArray array];
    self.array = @[@"我的收藏", @"夜间模式", @"清除缓存", @"意见反馈"];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = secondColor;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:@"userCell"];
    
    [_tableView release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        // 收藏
        CollectViewController *collectVC = [[CollectViewController alloc]init];
        [self.navigationController pushViewController:collectVC animated:YES];
        [collectVC release];
    }
    if (indexPath.row == 1) {
        // 夜间模式
        //从night中取出字符串
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        
        //当字符串是yes的时候发出no的消息
        if ([passWord isEqualToString:@"yes"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"black" object:@"no"];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"black" object:@"yes"];
        }
        
    }
    if (indexPath.row == 2) {
        // 清除缓存

        float tmpSize = [[SDImageCache sharedImageCache] getSize];
        
        NSString *clearMessage = tmpSize >= 1024 * 1024 ? [NSString stringWithFormat:@"清理缓存(%.2fM)" , tmpSize / 1024 / 1024] : [NSString stringWithFormat:@"清理缓存(%.2fK)", tmpSize / 1024];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:clearMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[SDImageCache sharedImageCache]clearDisk];
            
            //清除内存缓存
            [[[SDWebImageManager sharedManager] imageCache] clearMemory];
            
            //清除系统缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
        }];
        
        [alert addAction:action2];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];

    }
    if (indexPath.row == 3) {
        // 意见反馈
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"正在改进中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    [self createArray];
    
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
