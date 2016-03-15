//
//  StepPicViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "StepPicViewController.h"
#import "StepPicCell.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface StepPicViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@end

@implementation StepPicViewController
- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_stepPicArray release];
    [super dealloc];
}
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_flowLayout setItemSize:CGSizeMake(110*Screen_W , 170*Screen_H)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10*Screen_H, 10*Screen_W, 10*Screen_H, 10*Screen_W);
    self.flowLayout.minimumInteritemSpacing = 1*Screen_H;
    self.flowLayout.minimumLineSpacing = 10*Screen_H;
    [self.flowLayout release];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-114) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = secondColor;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[StepPicCell class] forCellWithReuseIdentifier:@"stepPicCell"];
    [self.collectionView release];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.stepPicArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StepPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"stepPicCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.stepImageView sd_setImageWithURL:[NSURL URLWithString:[self.stepPicArray[indexPath.item] objectForKey:@"pic_s"]]];
    cell.stepLabel.text = [self.stepPicArray[indexPath.item] objectForKey:@"content"];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item + 1];
    return cell;
}
/** 一点击item 就通过代理传index给MainCourseVC */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    // 让代理通过indexPath改变contentoffset,代理是MainCourseVC,目的调整collectionView(3个section的)的偏移量
    [self.delegate passIndexPath:indexPath];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部步骤";
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
