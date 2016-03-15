//
//  CollectViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/23.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CollectViewController.h"
#import "DataBaseHandle.h"
#import "CollectCell.h"
#import "UIImageView+WebCache.h"
#import "UsersDetailViewController.h"
#import "HeaderBase.h"

@interface CollectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) UIImageView *imageView1;
@end

@implementation CollectViewController
- (void)dealloc
{
    [_tableView release];
    [_collectArr release];
    [_imageView1 release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[DataBaseHandle sharedDataBase]openDB];
    self.collectArr = [[DataBaseHandle sharedDataBase] selecteCollect];

    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    self.imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dahai"]];
    self.imageView1.backgroundColor = [UIColor clearColor];
    self.imageView1.frame = self.view.bounds;
    [self.view addSubview:self.imageView1];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height+64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.alpha = 0.8;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView"];
    [self.tableView registerClass:[CollectCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [_tableView release];
    [_imageView1 release];
    
    
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
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*Screen_H;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CollectModel *collect = [self.collectArr objectAtIndex:indexPath.row];
    [cell.faceImageView sd_setImageWithURL:[NSURL URLWithString:collect.faceImage]];
    cell.nameLabel.text= collect.userName ;
    //NSLog(@"%@", collect.faceImage);
    //NSLog(@"%@", collect.name);
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CollectModel *collect = [self.collectArr objectAtIndex:indexPath.row];
        DataBaseHandle *dbhandle = [DataBaseHandle sharedDataBase];
        [dbhandle deleteCollectWithName:collect.userName];
        [self.collectArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UsersDetailViewController *peopleDetail = [[UsersDetailViewController alloc]init];
    CollectModel *collect = [self.collectArr objectAtIndex:indexPath.row];
    peopleDetail.useridStr = collect.userId;
    peopleDetail.nick_nameStr = collect.userName;
    peopleDetail.avatarStr = collect.faceImage;
    [self.navigationController pushViewController:peopleDetail animated:YES];
    [peopleDetail release];
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
