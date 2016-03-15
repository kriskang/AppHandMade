//
//  UserCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UserCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface UserCell ()
@property (nonatomic ,retain) UIView *bgView;
@end

@implementation UserCell
- (void)dealloc
{
    [_bgView release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = secondColor;
        [self.contentView addSubview:self.bgView];
        [_bgView release];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.layer.cornerRadius = 15;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        
        // 点击夜间模式
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        if ([passWord isEqualToString:@"yes"]) {
            self.bgView.backgroundColor = nightColor;
            self.titleLabel.backgroundColor = nightColorCell;
            self.titleLabel.textColor = [UIColor whiteColor];
        }
        
        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.bgView.backgroundColor = nightColor;
    self.titleLabel.backgroundColor = nightColorCell;
    self.titleLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.bgView.backgroundColor = secondColor;
        self.titleLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}


    

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height - 5);
    self.bgView.frame = self.contentView.frame;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
