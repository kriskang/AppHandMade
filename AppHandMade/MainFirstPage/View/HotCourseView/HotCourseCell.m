//
//  HotCourseCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HotCourseCell.h"
#import "TitleBarReusableView.h"
#import "HotCourseColCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ColorChange.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@implementation HotCourseCell
- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_courseArray release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [_flowLayout release];
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.scrollEnabled = NO;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self.collectionView registerClass:[TitleBarReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
        [self.collectionView registerClass:[HotCourseColCell class] forCellWithReuseIdentifier:@"hotCourse"];
        
        
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
    return  self;
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.courseArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCourseColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCourse" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5*Screen_H;
    cell.backgroundColor = [UIColor colorWithHexString:[self.courseArray[indexPath.item] objectForKey:@"bg_color"]];
    
    [cell.hostImageView sd_setImageWithURL:[NSURL URLWithString:[self.courseArray[indexPath.item] objectForKey:@"host_pic"]]];
    
    cell.subjectLabel.text = [self.courseArray[indexPath.item] objectForKey:@"subject"];
    cell.userName.text = [NSString stringWithFormat:@"by %@", [self.courseArray[indexPath.item] objectForKey:@"user_name"]];
    cell.infoLabel.text = [NSString stringWithFormat:@"%@人气 / %@收藏", [self.courseArray[indexPath.item]objectForKey:@"view"], [self.courseArray[indexPath.item] objectForKey:@"collect"]];
    
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TitleBarReusableView *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
        reuseView.titleBarLabel.text = @"  热门教程";
        
        return reuseView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hand_id = [[self.courseArray objectAtIndex:indexPath.item]objectForKey:@"hand_id"];
    self.hotCourseBlock();

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
    self.flowLayout.itemSize = CGSizeMake(180*Screen_W, 257*Screen_H);
    self.flowLayout.headerReferenceSize = CGSizeMake(100*Screen_W, 40*Screen_H);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 5*Screen_W, 0, 5*Screen_W);
    self.flowLayout.minimumInteritemSpacing = 5*Screen_H;
    self.flowLayout.minimumLineSpacing = 5*Screen_H;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
