//
//  BtnViewColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/16.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BtnViewColCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface BtnViewColCell ()
@property (nonatomic, retain) UIImageView *titleImageView;
@end
@implementation BtnViewColCell
- (void)dealloc
{
    [_titleLabel release];
    [_titleImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc]init];
//        self.titleLabel.backgroundColor = [UIColor yellowColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.titleImageView = [[UIImageView alloc]init];
        self.titleImageView.image = [UIImage imageNamed:@"icon_title"];
        [self.contentView addSubview:self.titleImageView];
        [_titleImageView release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = [UIColor colorWithRed:0.033 green:0.061 blue:0.114 alpha:0.601];
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = [UIColor colorWithRed:0.121 green:0.221 blue:0.406 alpha:0.500];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.titleLabel.frame = CGRectMake(40*Screen_W, 0, self.contentView.frame.size.width - 10*Screen_W, self.contentView.frame.size.height);
    self.titleImageView.frame = CGRectMake(0, 0, 35*Screen_W, self.contentView.frame.size.height);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
