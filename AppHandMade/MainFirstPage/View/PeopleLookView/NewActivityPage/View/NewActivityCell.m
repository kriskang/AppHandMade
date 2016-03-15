//
//  NewActivityCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "NewActivityCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]


@implementation NewActivityCell
- (void)dealloc
{
    [_titleImageView release];
    [_nameLabel release];
    [_timeLabel release];
    [_statusLabel release];
    [_bgView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [_bgView release];
        
        self.titleImageView = [[UIImageView alloc]init];
//        self.titleImageView.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:self.titleImageView];
        [_titleImageView release];
        
        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.backgroundColor = [UIColor blueColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13*Screen_H];
        [self.bgView addSubview:self.nameLabel];
        [_nameLabel release];
        
        self.timeLabel = [[UILabel alloc]init];
//        self.timeLabel.backgroundColor = [UIColor yellowColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        [self.bgView addSubview:self.timeLabel];
        [_timeLabel release];
        
        self.statusLabel = [[UILabel alloc]init];
//        self.statusLabel.backgroundColor = [UIColor orangeColor];
        self.statusLabel.font = [UIFont systemFontOfSize:10*Screen_H];
        [self.bgView addSubview:self.statusLabel];
        [_statusLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColor;
            self.bgView.backgroundColor = [UIColor colorWithRed:0.121 green:0.355 blue:0.694 alpha:0.810];
            self.nameLabel.textColor = [UIColor whiteColor];
            self.timeLabel.textColor = [UIColor whiteColor];
            self.statusLabel.textColor = [UIColor whiteColor];
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.bgView.backgroundColor = nightColorCell;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.statusLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [UIColor blackColor];
        self.statusLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 5*Screen_H);
    self.titleImageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 45*Screen_H);
    self.nameLabel.frame = CGRectMake(5*Screen_H, self.contentView.frame.size.height - 45*Screen_H, self.contentView.frame.size.width, 20*Screen_H);
    self.timeLabel.frame = CGRectMake(5*Screen_H, self.contentView.frame.size.height - 25*Screen_H, self.contentView.frame.size.width - 50*Screen_H, 20*Screen_H);
    self.statusLabel.frame = CGRectMake(self.contentView.frame.size.width - 55*Screen_H, self.contentView.frame.size.height - 25*Screen_H, 50*Screen_H, 20*Screen_H);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
