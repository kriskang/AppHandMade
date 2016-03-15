//
//  StepPicCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "StepPicCell.h"
#import "HeaderBase.h"

@implementation StepPicCell
- (void)dealloc
{
    [_stepImageView release];
    [_stepLabel release];
    [_numLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

            self.stepImageView = [[UIImageView alloc]init];
//            self.stepImageView.backgroundColor = [UIColor orangeColor];
            [self.contentView addSubview:self.stepImageView];
            [_stepImageView release];
            
            self.stepLabel = [[UILabel alloc]init];
//            self.stepLabel.backgroundColor = [UIColor redColor];
            self.stepLabel.font = [UIFont systemFontOfSize:11*Screen_H];
            self.stepLabel.numberOfLines = 0;
            [self.stepLabel sizeToFit];
            [self.contentView addSubview:self.stepLabel];
            [_stepLabel release];
            
            self.numLabel = [[UILabel alloc]init];
            self.numLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.690];
            self.numLabel.font = [UIFont systemFontOfSize:13*Screen_H];
            self.numLabel.textColor = [UIColor whiteColor];
            self.numLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:self.numLabel];
            [_numLabel release];
        
            // 夜间模式点击后执行
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
            //从night中取出储存的字符串(yes,day)
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *passWord = [user objectForKey:@"night"];
            //判断字符串信息
            if ([passWord isEqualToString:@"yes"]) {
                self.contentView.backgroundColor = nightColor;
                self.stepLabel.backgroundColor = nightColorCell;
                self.stepLabel.textColor = [UIColor whiteColor];
        }


    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.stepLabel.backgroundColor = nightColorCell;
    self.stepLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.stepLabel.backgroundColor = [UIColor whiteColor];
        self.stepLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.stepImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 50*Screen_H);
    self.stepLabel.frame = CGRectMake(5, self.contentView.bounds.size.height - 50*Screen_H, self.contentView.bounds.size.width -10*Screen_W, 45*Screen_H);
    self.numLabel.frame = CGRectMake(0, 5, 20, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
