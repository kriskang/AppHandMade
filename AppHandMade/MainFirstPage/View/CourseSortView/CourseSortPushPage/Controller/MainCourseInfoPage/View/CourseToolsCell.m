//
//  CourseToolsCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseToolsCell.h"
#import "CourseToolsColCell.h"
#import "TitleBarView.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface CourseToolsCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@end
@implementation CourseToolsCell
- (void)dealloc
{
    [_toolsArray release];
    [_materialArray release];
    [_collectionView release];
    [_flowLayout release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [_flowLayout release];
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
        //self.collectionView.scrollEnabled = NO;
        
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = secondColor;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self.collectionView registerClass:[TitleBarView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
        
        [self.collectionView registerClass:[CourseToolsColCell class] forCellWithReuseIdentifier:@"courseToolsColCell"];
        
        [self.contentView addSubview:self.collectionView];
        [_collectionView release];
        
        
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
    return self;
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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.materialArray.count;
    } else {
        return self.toolsArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseToolsColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseToolsColCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.nameLabel.text = [self.materialArray[indexPath.item] objectForKey:@"name"];
        cell.numLabel.text = [self.materialArray[indexPath.item] objectForKey:@"num"];
    }
    else if (indexPath.section == 1)
    {
        cell.nameLabel.text = [self.toolsArray[indexPath.item] objectForKey:@"name"];
        cell.numLabel.text = [self.toolsArray[indexPath.item] objectForKey:@"num"];
    }

    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            
            TitleBarView *titleBar = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
            
            //titleBar.backgroundColor = secondColor;
            
            titleBar.titleBarLabel.text = @"准备材料";
            titleBar.titleBarLabel.textAlignment = NSTextAlignmentCenter;
//            titleBar.titleBarLabel.font = [UIFont systemFontOfSize:15];
            return titleBar;
            
        }
        if (indexPath.section == 1) {
            TitleBarView *titleBar = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
            
            titleBar.titleBarLabel.text = @"准备工具";
            titleBar.titleBarLabel.textAlignment = NSTextAlignmentCenter;
//            titleBar.titleBarLabel.font = [UIFont systemFontOfSize:15];
            return titleBar;
        }
    }
    return nil;

}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [self.flowLayout setItemSize:CGSizeMake(self.contentView.bounds.size.width, 35*Screen_H)];
    
    self.flowLayout.headerReferenceSize = CGSizeMake(100*Screen_W, 35*Screen_H);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
