//
//  SearchClassCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/21.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SearchClassCell.h"
#import "HeaderBase.h"

@implementation SearchClassCell
- (void)dealloc
{
    [_bgImageView release];
    [_titleLabel release];
    [_nameLabel release];
    [_timeLabel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView = [[UIImageView alloc]init];
//        self.bgImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:13*Screen_H];
//        self.titleLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        self.nameLabel.textColor = [UIColor grayColor];
//        self.nameLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.nameLabel];
        [_nameLabel release];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12*Screen_H];
//        self.timeLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColorCell;
            self.nameLabel.textColor = [UIColor whiteColor];
            self.titleLabel.textColor = [UIColor whiteColor];
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.backgroundColor = nightColorCell;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.bgImageView.frame = CGRectMake(5*Screen_W, 5*Screen_H, 50*Screen_W, 50*Screen_H);
    self.titleLabel.frame = CGRectMake(65*Screen_W, 5*Screen_H, 200*Screen_W, 20*Screen_H);
    self.nameLabel.frame = CGRectMake(65*Screen_W, 35*Screen_H, 190*Screen_W, 20*Screen_H);
    self.timeLabel.frame = CGRectMake(270*Screen_W, 35*Screen_H, 100*Screen_W, 20*Screen_H);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
