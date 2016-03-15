//
//  CourseStepCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseStepCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@implementation CourseStepCell
- (void)dealloc
{
    [_stepImageView release];
    [_stepBtn release];
    [_stepLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.stepImageView = [[UIImageView alloc]init];
//        self.stepImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.stepImageView];
        [_stepImageView release];
        
        self.stepLabel = [[UILabel alloc]init];
        self.stepLabel.backgroundColor = secondColor;
//        self.stepLabel.backgroundColor = [UIColor purpleColor];
        self.stepLabel.font = [UIFont systemFontOfSize:15*Screen_H];
        self.stepLabel.numberOfLines = 0;
        [self.contentView addSubview:self.stepLabel];
        [_stepLabel release];
        
        self.stepBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.stepBtn.layer.cornerRadius = 10*Screen_H;
        self.stepBtn.backgroundColor = [UIColor colorWithRed:0.404 green:0.420 blue:0.418 alpha:0.421];
        [self.stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.stepBtn.titleLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        [self.contentView addSubview:self.stepBtn];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColor;
            self.stepLabel.backgroundColor = nightColor;
            self.stepLabel.textColor = [UIColor whiteColor];
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.stepLabel.backgroundColor = nightColor;
    self.stepLabel.textColor = [UIColor whiteColor];

    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
        self.stepLabel.backgroundColor = secondColor;
        self.stepLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.stepImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height -100);
    self.stepLabel.frame = CGRectMake(20, self.contentView.bounds.size.height - 100, self.contentView.bounds.size.width-40, 85);
    self.stepBtn.frame = CGRectMake((self.contentView.bounds.size.width -80)/2, 10, 80, 25);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
