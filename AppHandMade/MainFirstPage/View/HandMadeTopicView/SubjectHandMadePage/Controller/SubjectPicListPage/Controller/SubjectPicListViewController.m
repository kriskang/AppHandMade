//
//  SubjectPicListViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/20.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SubjectPicListViewController.h"
#import "SubjectPicListModel.h"
#import "SubjectPicListCell.h"
#import "MainCourseInfoViewController.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface SubjectPicListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) SubjectPicListModel *subjectPicListModel;

@end

@implementation SubjectPicListViewController
- (void)dealloc
{
    [_idStr release];
    [_collectionView release];
    [_flowLayout release];
    [_subjectPicListModel release];
    [super dealloc];
}
- (void)handleData
{
    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=topic&id=%@", self.idStr];
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.subjectPicListModel = [[SubjectPicListModel alloc]init];
        NSMutableDictionary *dataDic = responseObject[@"data"];
        [self.subjectPicListModel setValuesForKeysWithDictionary:dataDic];
        [_subjectPicListModel release];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width/2, 200*Screen_H)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10*Screen_H, 0);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    [_flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    [self.view addSubview:self.collectionView];
    //_collectionView.scrollEnabled = NO;
    
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = secondColor;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[SubjectPicListCell class] forCellWithReuseIdentifier:@"subjectPicListCell"];
    [_collectionView release];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.subjectPicListModel.course.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SubjectPicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subjectPicListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.eachImageView sd_setImageWithURL:[NSURL URLWithString:[[self.subjectPicListModel.course objectAtIndex:indexPath.item] objectForKey:@"thumb"]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCourseInfoViewController *mainCourseInfoVC = [[MainCourseInfoViewController alloc]init];
    [self.navigationController pushViewController:mainCourseInfoVC animated:YES];
    mainCourseInfoVC.hand_id = [self.subjectPicListModel.course[indexPath.item] objectForKey:@"hand_id"];
    [mainCourseInfoVC release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情图片";
    [self handleData];
    [self createCollectionView];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        self.collectionView.backgroundColor = nightColor;
    }
}
- (void)changeColor:(NSNotification *)notification
{
    self.collectionView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.collectionView.backgroundColor = secondColor;
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
