//
//  PeopleLookColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "PeopleLookColCell.h"
#import "HeaderBase.h"

@implementation PeopleLookColCell
- (void)dealloc
{
    [_leftImageView release];
    [_titleLabel release];
    [_rightLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.leftImageView = [[UIImageView alloc]init];
//        self.leftImageView.backgroundColor = [UIColor yellowColor];
        self.leftImageView.layer.masksToBounds = YES;
        self.leftImageView.layer.cornerRadius = 8*Screen_H;
        [self addSubview:self.leftImageView];
        [_leftImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
//        self.titleLabel.backgroundColor = [UIColor purpleColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.rightLabel = [[UILabel alloc]init];
//        self.rightLabel.backgroundColor = [UIColor blueColor];
        self.rightLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        [self addSubview:self.rightLabel];
        [_rightLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.titleLabel.textColor = [UIColor whiteColor];
            self.rightLabel.textColor = [UIColor whiteColor];
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.titleLabel.textColor = [UIColor whiteColor];
    self.rightLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.titleLabel.textColor = [UIColor blackColor];
        self.rightLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.leftImageView.frame = CGRectMake(5*Screen_W, 5*Screen_H, 75*Screen_W, 75*Screen_H);
    self.titleLabel.frame = CGRectMake(85*Screen_W, 15*Screen_H, 280*Screen_W, 30*Screen_H);
    self.rightLabel.frame = CGRectMake(85*Screen_W, 45*Screen_H, 280*Screen_W, 30*Screen_H);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
