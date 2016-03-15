//
//  NewWorksColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "NewWorksColCell.h"
#import "HeaderBase.h"

@implementation NewWorksColCell
- (void)dealloc
{
    [_hostImageView release];
    [_titleLabel release];
    [_voteLabel release];
    [_userNameLabel release];
    [_headImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hostImageView = [[UIImageView alloc]init];
        self.hostImageView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        [self.contentView addSubview:self.hostImageView];
        [_hostImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
        //self.titleLable.backgroundColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13*Screen_H];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.voteLabel = [[UILabel alloc]init];
        //self.voteLable.backgroundColor = [UIColor yellowColor];
        self.voteLabel.font = [UIFont systemFontOfSize:11*Screen_H];
        self.voteLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.voteLabel];
        [_voteLabel release];
        
        self.userNameLabel = [[UILabel alloc]init];
        //self.nameLable.backgroundColor = [UIColor purpleColor];
        self.userNameLabel.font = [UIFont systemFontOfSize:10*Screen_H];
        self.userNameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.userNameLabel];
        [_userNameLabel release];
        
        self.headImageView = [[UIImageView alloc]init];
        //self.headerImageView.backgroundColor = [UIColor blueColor];
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 10*Screen_H;
        [self.contentView addSubview:self.headImageView];
        [self.headImageView release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColorCell;
            self.titleLabel.textColor = [UIColor whiteColor];
            self.userNameLabel.textColor = [UIColor whiteColor];
            self.voteLabel.textColor = [UIColor whiteColor];
        }
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.titleLabel.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = nightColorCell;
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.voteLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.titleLabel.textColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.userNameLabel.textColor = [UIColor blackColor];
        self.voteLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.hostImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 170*Screen_H);
    self.titleLabel.frame = CGRectMake(5*Screen_W, 180*Screen_H, self.contentView.bounds.size.width -10*Screen_W, 25*Screen_H);
    self.voteLabel.frame = CGRectMake(5*Screen_W, 210*Screen_H, self.contentView.bounds.size.width- 10*Screen_W, 20*Screen_H);
    self.headImageView.frame = CGRectMake(self.contentView.bounds.size.width - 30*Screen_W, 225*Screen_H, 20*Screen_W, 20*Screen_H);
    self.userNameLabel.frame = CGRectMake(10*Screen_W, 225*Screen_H, self.contentView.bounds.size.width - 45*Screen_W, 25*Screen_H);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
