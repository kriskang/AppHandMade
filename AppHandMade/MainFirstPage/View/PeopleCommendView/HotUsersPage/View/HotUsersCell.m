//
//  HotUsersCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HotUsersCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@implementation HotUsersCell
- (void)dealloc
{
    [_bgView release];
    [_headImageView release];
    [_nameLabel release];
    [_infoLabel release];
    [_rightImageView release];
    [_centerImageView release];
    [_leftImageView release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgView = [[UIImageView alloc]init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [_bgView release];
        
        self.headImageView = [[UIImageView alloc]init];
//        self.headImageView.backgroundColor = [UIColor magentaColor];
        self.headImageView.layer.masksToBounds = YES;
        [self.bgView addSubview:self.headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.backgroundColor = [UIColor greenColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:self.nameLabel];
        [_nameLabel release];
        
        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor orangeColor];
        self.infoLabel.font = [UIFont systemFontOfSize:11*Screen_H];
        self.infoLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:self.infoLabel];
        [self.infoLabel release];
        
        self.leftImageView = [[UIImageView alloc]init];
//        self.leftImageView.backgroundColor = [UIColor cyanColor];
        [self.bgView addSubview:self.leftImageView];
        [_leftImageView release];
        
        self.centerImageView = [[UIImageView alloc]init];
//        self.centerImageView.backgroundColor = [UIColor yellowColor];
        [self.bgView addSubview:self.centerImageView];
        [_centerImageView release];
        
        self.rightImageView = [[UIImageView alloc]init];
//        self.rightImageView.backgroundColor = [UIColor brownColor];
        [self.bgView addSubview:self.rightImageView];
        [_rightImageView release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColor;
            self.bgView.backgroundColor = nightColorCell;
            self.nameLabel.textColor = [UIColor whiteColor];
            self.infoLabel.textColor = [UIColor whiteColor];
            
        }
        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.bgView.backgroundColor = nightColorCell;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.infoLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.infoLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame =CGRectMake(0, 10*Screen_H, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 10*Screen_H);
    self.headImageView.frame = CGRectMake(10*Screen_H, 8*Screen_H, 50*Screen_H, 50*Screen_H);
    self.headImageView.layer.cornerRadius = (50*Screen_H)/2;

    self.nameLabel.frame = CGRectMake(65*Screen_W, 10*Screen_H, 150*Screen_W, 25*Screen_H);
    self.infoLabel.frame = CGRectMake(65*Screen_W, 35*Screen_H, 150*Screen_W, 20*Screen_H);
    self.leftImageView.frame = CGRectMake(0, 60*Screen_H, self.contentView.bounds.size.width/3-1*Screen_W, 135*Screen_H);
    self.centerImageView.frame = CGRectMake(self.contentView.bounds.size.width/3, 60*Screen_H, self.contentView.bounds.size.width/3-1*Screen_W, 135*Screen_H);
    self.rightImageView.frame = CGRectMake(self.contentView.bounds.size.width/3*2, 60*Screen_H, self.contentView.bounds.size.width/3-1*Screen_W, 135*Screen_H);
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
