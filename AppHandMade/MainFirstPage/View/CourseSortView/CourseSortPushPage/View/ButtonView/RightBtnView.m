//
//  RightBtnView.m
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "RightBtnView.h"
#import "BtnViewColCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface RightBtnView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) NSArray *orderStr;
@property (nonatomic, retain) NSArray *order_idStr;
@end
@implementation RightBtnView
- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_orderStr release];
    [_order_idStr release];
    Block_release(_rightBtnBlock);
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.orderStr = @[@"最热教程",@"最新更新", @"评论最多", @"收藏最多",@"材料包有售", @"成品有售"];
        self.order_idStr = @[@"hot", @"new", @"comment", @"collect", @"material", @"goods"];
        [self createCollectionView];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.collectionView.backgroundColor = nightColorCell;
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.collectionView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[BtnViewColCell class] forCellWithReuseIdentifier:@"btnViewColCell"];
    
    [self addSubview:self.collectionView];
    [_collectionView release];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.orderStr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnViewColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnViewColCell" forIndexPath:indexPath];
    cell.backgroundColor = secondColor;
    cell.titleLabel.text = self.orderStr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.rightBtnBlock(self.orderStr[indexPath.item], self.order_idStr[indexPath.item]);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.flowLayout.itemSize = CGSizeMake(350*Screen_W, 40*Screen_H);
    self.collectionView.frame = self.bounds;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10*Screen_H, 10*Screen_W, 10*Screen_H, 10*Screen_W);
    self.flowLayout.minimumLineSpacing = 3*Screen_H;
    self.flowLayout.minimumInteritemSpacing = 3*Screen_H;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
