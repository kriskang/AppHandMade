//
//  PeopleLookCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "PeopleLookCell.h"
#import "PeopleLookColCell.h"
#import "TitleBarReusableView.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface PeopleLookCell ()

@end
@implementation PeopleLookCell
- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_relationsDic release];
    
    Block_release(_newActivityBlock);
    Block_release(_hotMaterialBlock);
    Block_release(_bestHandeMadeBlock);
    
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
    [self.flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[PeopleLookColCell class] forCellWithReuseIdentifier:@"peopleLook"];
    [self.collectionView registerClass:[TitleBarReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
    
    [self.contentView addSubview:self.collectionView];
    [_collectionView release];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleLookColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"peopleLook" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.5];
    
    if (self.relationsDic.count != 0) {
        if (indexPath.item == 0) {
            cell.titleLabel.text = @"好友动态";
            [cell.leftImageView sd_setImageWithURL:[self.relationsDic[@"dynamic"] objectForKey:@"pic"]];
            cell.rightLabel.text = [self.relationsDic[@"dynamic"] objectForKey:@"title"];
        }
        if (indexPath.item == 1) {
            cell.titleLabel.text = @"最新活动";
            [cell.leftImageView sd_setImageWithURL:[self.relationsDic[@"competition"] objectForKey:@"pic"]];
            cell.rightLabel.text = [self.relationsDic[@"competition"] objectForKey:@"c_name"];

        }
        if (indexPath.item == 2) {
            cell.titleLabel.text = @"热门材料包";
            [cell.leftImageView sd_setImageWithURL:[self.relationsDic[@"material"] objectForKey:@"host_pic"]];
            cell.rightLabel.text = [self.relationsDic[@"material"] objectForKey:@"subject"];

        }
        if (indexPath.item == 3) {
            cell.titleLabel.text = @"精选手工";
            [cell.leftImageView sd_setImageWithURL:[self.relationsDic[@"goods"] objectForKey:@"host_pic"]];
            cell.rightLabel.text = [self.relationsDic[@"goods"] objectForKey:@"subject"];

        }
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TitleBarReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
        reusableView.titleBarLabel.text = @"  大家都在看";
        return reusableView;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        self.newActivityBlock();
    }
    if (indexPath.row == 2) {
        self.nameStr = @"全部分类";
        self.timeStr = @"全部教程";
        self.orderStr = @"材料包有售";
        
        self.cate_idStr = @"&gcate=allcate";
        self.pub_timeStr = @"all";
        self.order_Str = @"material";
        self.hotMaterialBlock();
        
    }
    if (indexPath.row == 3) {
        self.nameStr = @"全部分类";
        self.timeStr = @"全部教程";
        self.orderStr = @"材料包有售";
        
        self.cate_idStr = @"&gcate=allcate";
        self.pub_timeStr = @"all";
        self.order_Str = @"goods";
        self.bestHandeMadeBlock();
        
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
    
    self.flowLayout.itemSize = CGSizeMake(self.contentView.frame.size.width - 3, 83*Screen_H);
    
    self.flowLayout.headerReferenceSize = CGSizeMake(100*Screen_W, 40*Screen_H);
    
    self.flowLayout.minimumInteritemSpacing = 3*Screen_H;
    self.flowLayout.minimumLineSpacing = 3*Screen_H;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
