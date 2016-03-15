//
//  UsersContentCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UsersContentCell.h"
#import "TitleBarUserView.h"
#import "UsersContentColCell.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface UsersContentCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@end
@implementation UsersContentCell

- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_list release];
    [_hand_idStr release];
    Block_release(_usersContentBlock);
    [super dealloc];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        self.collectionView.backgroundColor = secondColor;
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
    [self.contentView addSubview:self.collectionView];
    self.collectionView.scrollEnabled = NO;
    [_flowLayout release];
    
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[TitleBarUserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleBar"];
    
    [self.collectionView registerClass:[UsersContentColCell class] forCellWithReuseIdentifier:@"usersContentColCell"];
    [_collectionView release];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UsersContentColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"usersContentColCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.hostImageView sd_setImageWithURL:[NSURL URLWithString:[[self.list objectAtIndex:indexPath.item] objectForKey:@"host_pic_s"]]];
    cell.titleLabel.text = [[self.list objectAtIndex:indexPath.item]objectForKey:@"subject"];
//    NSLog(@"%@",[[self.list objectAtIndex:indexPath.item]objectForKey:@"hand_id"]);

    cell.infoLabel.text = [NSString stringWithFormat:@"%@人气|%@赞",[[self.list objectAtIndex:indexPath.item]objectForKey:@"view"],[[self.list objectAtIndex:indexPath.item]objectForKey:@"collect"]];

    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        TitleBarUserView *titleBar = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"titleBar" forIndexPath:indexPath];
        titleBar.titleBarLabel.text = @"  达人发布教程:";
        
        return titleBar;
    }
    
    
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hand_idStr = [[self.list objectAtIndex:indexPath.item]objectForKey:@"hand_id"];
    self.usersContentBlock();
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [_flowLayout setItemSize:CGSizeMake((self.contentView.bounds.size.width -30)/2, 230)];
    
    _flowLayout.headerReferenceSize = CGSizeMake(100, 30);
    _collectionView.frame = self.contentView.bounds;
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.minimumInteritemSpacing = 0;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
