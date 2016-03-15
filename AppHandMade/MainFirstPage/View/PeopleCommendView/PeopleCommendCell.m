//
//  PeopleCommendCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "PeopleCommendCell.h"
#import "HeaderBase.h"


#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

#define peopleCommendCell_W self.contentView.frame.size.width
#define peopleCommendCell_H self.contentView.frame.size.height

@interface PeopleCommendCell ()
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation PeopleCommendCell

- (void)dealloc
{
    [_titleLabel release];
    [_bgImageView release];
    [_headImageView release];
    [_userName release];
    [_userLocation release];
    [_infoLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = @"  达人推荐";
        self.titleLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        
        self.bgImageView = [[UIImageView alloc]init];
//        self.bgImageView.backgroundColor = [UIColor cyanColor];
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.layer.cornerRadius = 8*Screen_H;
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView release];
        
        
        self.headImageView = [[UIImageView alloc]init];
//        self.headImageView.backgroundColor = [UIColor blueColor];
        self.headImageView.layer.masksToBounds = YES;
        [self.bgImageView addSubview:self.headImageView];
        [_headImageView release];
        
        
        self.userName = [[UILabel alloc]init];
//        self.userName.backgroundColor = [UIColor brownColor];
        self.userName.textAlignment = NSTextAlignmentCenter;
        self.userName.font = [UIFont systemFontOfSize:15*Screen_H];
        [self.bgImageView addSubview:self.userName];
        [_userName release];
        
        
        self.userLocation = [[UILabel alloc]init];
//        self.userLocation.backgroundColor = [UIColor purpleColor];
        self.userLocation.textAlignment = NSTextAlignmentCenter;
        self.userLocation.font = [UIFont systemFontOfSize:13*Screen_H];

        [self.bgImageView addSubview:self.userLocation];
        [_userLocation release];

        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor redColor];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        [self.bgImageView addSubview:self.infoLabel];
        [_infoLabel release];
        

        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColor;
            self.titleLabel.backgroundColor = nightColor;
            self.titleLabel.textColor = [UIColor whiteColor];
            self.bgImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1];
            self.bgImageView.alpha = 0.8;
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.titleLabel.backgroundColor = nightColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.bgImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1];
    self.bgImageView.alpha = 0.8;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.bgImageView.backgroundColor = [UIColor clearColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageView.frame = CGRectMake(5*Screen_W, 40*Screen_H, peopleCommendCell_W - 10*Screen_W, peopleCommendCell_H - 43*Screen_H);
    self.titleLabel.frame = CGRectMake(0, 0, peopleCommendCell_W, 40*Screen_H);
    
    self.headImageView.frame = CGRectMake((self.bgImageView.frame.size.width - 80*Screen_W) / 2, 20*Screen_H, 80*Screen_W, 80*Screen_W);
    self.headImageView.layer.cornerRadius = (80*Screen_W)/2;

    
    
    self.userName.frame = CGRectMake((self.bgImageView.frame.size.width - 140*Screen_W) / 2, 110*Screen_H, 140*Screen_W, 40*Screen_H);
    self.userLocation.frame = CGRectMake((self.bgImageView.frame.size.width - 140*Screen_W) / 2, 155*Screen_H, 140*Screen_W, 30*Screen_H);
    
    self.infoLabel.frame = CGRectMake((self.bgImageView.frame.size.width - 200*Screen_W) / 2, 200*Screen_H, 200*Screen_W, 30*Screen_H);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
