//
//  HandMadeTopicCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HandMadeTopicCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define HandMadeTopicCell_W self.contentView.frame.size.width
#define HandMadeTopicCell_H self.contentView.frame.size.height

@interface HandMadeTopicCell ()
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation HandMadeTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = @"  手工专题";
        self.titleLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.5];
        self.bgImageView.layer.cornerRadius = 8*Screen_H;
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView release];
        
        self.leftImageView = [[UIImageView alloc] init];
//        self.leftImageView.backgroundColor = [UIColor blueColor];
        [self.bgImageView addSubview:self.leftImageView];
        [_leftImageView release];
        
        self.rightImageView1 = [[UIImageView alloc] init];
//        self.rightImageView1.backgroundColor = [UIColor redColor];
        [self.bgImageView addSubview:self.rightImageView1];
        [_rightImageView1 release];
        
        self.rightImageView2 = [[UIImageView alloc] init];
//        self.rightImageView2.backgroundColor = [UIColor brownColor];
        [self.bgImageView addSubview:self.rightImageView2];
        [_rightImageView2 release];
        
        self.rightImageView3 = [[UIImageView alloc] init];
//        self.rightImageView3.backgroundColor = [UIColor orangeColor];
        [self.bgImageView addSubview:self.rightImageView3];
        [_rightImageView3 release];
        
        self.rightImageView4 = [[UIImageView alloc] init];
//        self.rightImageView4.backgroundColor = [UIColor greenColor];
        [self.bgImageView addSubview:self.rightImageView4];
        [_rightImageView4 release];
        
        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor yellowColor];
        self.infoLabel.font = [UIFont systemFontOfSize:13*Screen_H];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
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
            self.titleLabel.textColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = nightColor;
            self.infoLabel.textColor = nightColor;
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = nightColor;
    self.infoLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.infoLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageView.frame = CGRectMake(5*Screen_W, 40*Screen_H, HandMadeTopicCell_W - 10*Screen_W, HandMadeTopicCell_H - 43*Screen_H);
    self.titleLabel.frame = CGRectMake(0, 0, HandMadeTopicCell_W, 40*Screen_H);
    
    self.leftImageView.frame = CGRectMake(30*Screen_W, 10*Screen_H, 151*Screen_W, 151*Screen_H);
    self.rightImageView1.frame = CGRectMake((30+151+1)*Screen_W, 10*Screen_H, 75*Screen_W, 75*Screen_H);
    self.rightImageView2.frame = CGRectMake((30+151+1+75+1)*Screen_W, 10*Screen_H, 75*Screen_W, 75*Screen_H);
    self.rightImageView3.frame = CGRectMake((30+151+1)*Screen_W, (10+75+1)*Screen_H, 75*Screen_W, 75*Screen_H);
    self.rightImageView4.frame = CGRectMake((30+151+1+75+1)*Screen_W, (10+75+1)*Screen_H, 75*Screen_W, 75*Screen_H);
    
    self.infoLabel.frame = CGRectMake(30*Screen_W, (10+151+5)*Screen_H, 300*Screen_W, 30*Screen_H);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
