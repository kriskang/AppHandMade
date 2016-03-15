//
//  NewWorksCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "NewWorksCell.h"
#import "NewWorksColCell.h"
#import "UIImageView+WebCache.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface NewWorksCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@end
@implementation NewWorksCell
- (void)dealloc
{
    [_dataArray release];
    [_collectionView release];
    [_flowLayout release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [_flowLayout release];
        
        self. collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
        [self.contentView addSubview:self.collectionView];
        
        
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = secondColor;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
        [self.collectionView registerClass:[NewWorksColCell class] forCellWithReuseIdentifier:@"newWorksColCell"];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewWorksColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newWorksColCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5*Screen_H;
    
    cell.titleLabel.text = [[self.dataArray objectAtIndex:indexPath.item]objectForKey:@"subject"];
    cell.voteLabel.text =[[[self.dataArray objectAtIndex:indexPath.item]objectForKey:@"votes"] stringByAppendingString:@"投票"];
    cell.userNameLabel.text =[[self.dataArray objectAtIndex:indexPath.item]objectForKey:@"uname"];
    [cell.hostImageView sd_setImageWithURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:indexPath.item]objectForKey:@"host_pic"]]];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:indexPath.item]objectForKey:@"avatar"]]];
    
    return cell;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [self.flowLayout setItemSize:CGSizeMake(170*Screen_W, 250*Screen_H)];
    self.collectionView.frame = self.contentView.bounds;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10*Screen_H, 10*Screen_W, 10*Screen_H, 10*Screen_W);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
