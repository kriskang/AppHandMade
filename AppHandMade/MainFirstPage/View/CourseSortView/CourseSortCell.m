//
//  CourseSortCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseSortCell.h"
#import "CourseSortColCell.h"
#import "UIImageView+WebCache.h"
#import "TitleBarReusableView.h"
#import "HeaderBase.h"

@implementation CourseSortCell
- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_gcateArray release];
    
    Block_release(_courseBlock);
    
    [_nameStr release];
    [_timeStr release];
    [_orderStr release];
    [_cate_idStr release];
    [_pub_timeStr release];
    [_order_Str release];
    [super dealloc];
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CourseSortColCell class] forCellWithReuseIdentifier:@"courseSortColCell"];
    [self.collectionView registerClass:[TitleBarReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
    
    [_flowLayout release];
    [_collectionView release];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseSortColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseSortColCell" forIndexPath:indexPath];
    // cell浅灰背景色
    cell.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.5];
    
    if (self.gcateArray.count != 0) {
        cell.sortTitleLabel.text = [[self.gcateArray objectAtIndex:indexPath.item] objectForKey:@"cate_name"];
        [cell.sortImageView sd_setImageWithURL:[NSURL URLWithString:[[self.gcateArray objectAtIndex:indexPath.item] objectForKey:@"cate_pic"]]];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TitleBarReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
        reusableView.titleBarLabel.text = @"  教程分类";
        return reusableView;
    }
    return nil;
}

/** collectionViewCell点击 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 7) {
        self.nameStr = [self.gcateArray[indexPath.item] objectForKey:@"cate_name"];
        self.timeStr = @"一周";
        self.orderStr = @"最新更新";
        
        self.cate_idStr = [NSString stringWithFormat:@"%@&gcate=allcate", [self.gcateArray[indexPath.item] objectForKey:@"cate_id"]];
        self.pub_timeStr = @"week";
        self.order_Str = @"new";
        
    } else {
        
        self.nameStr = [self.gcateArray[indexPath.item] objectForKey:@"cate_name"];
        self.timeStr = @"一周";
        self.orderStr = @"最热教程";
        
        self.cate_idStr = [NSString stringWithFormat:@"&cate_id=%@&gcate=cate", [self.gcateArray[indexPath.item] objectForKey:@"cate_id"]];
        self.pub_timeStr = @"week";
        self.order_Str = @"hot";
    }
    self.courseBlock();
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
    
    [self.flowLayout setItemSize:CGSizeMake(90 * Screen_W, 90 * Screen_H)];
    
    self.flowLayout.headerReferenceSize = CGSizeMake(100 *Screen_W, 40 *Screen_H);
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 3*Screen_W, 0, 3*Screen_W);
    self.flowLayout.minimumInteritemSpacing = 3 *Screen_W;
    self.flowLayout.minimumLineSpacing = 3*Screen_W;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
