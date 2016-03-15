//
//  SubjectHandMadeCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/20.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SubjectHandMadeCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]


@implementation SubjectHandMadeCell
- (void)dealloc
{
    [_bgView release];
    [_imageView1 release];
    [_imageView2 release];
    [_imageView3 release];
    [_imageView4 release];
    [_titleLabel release];
    [_rightImageView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [_bgView release];
        
        self.rightImageView = [[UIImageView alloc]init];
//        self.rightImageView.backgroundColor = [UIColor yellowColor];
        [self.bgView addSubview:self.rightImageView];
        [_rightImageView release];
        
        self.imageView1 = [[UIImageView alloc]init];
//        self.imageView1.backgroundColor = [UIColor brownColor];
        [self.bgView addSubview:self.imageView1];
        [_imageView1 release];
        
        self.imageView2 = [[UIImageView alloc]init];
//        self.imageView2.backgroundColor = [UIColor purpleColor];
        [self.bgView addSubview:self.imageView2];
        [_imageView2 release];
        
        self.imageView3 = [[UIImageView alloc]init];
//        self.imageView3.backgroundColor = [UIColor brownColor];
        [self.bgView addSubview:self.imageView3];
        [_imageView3 release];
        
        self.imageView4 = [[UIImageView alloc]init];
        //self.imageView4.backgroundColor = [UIColor purpleColor];
        [self.bgView addSubview:self.imageView4];
        [_imageView4 release];
        
        self.titleLabel = [[UILabel alloc]init];
//        self.titleLabel.backgroundColor = [UIColor blueColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:self.titleLabel];
        [_titleLabel release];

        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColor;
            self.bgView.backgroundColor = nightColorCell;
            self.titleLabel.textColor = [UIColor whiteColor];
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.bgView.backgroundColor = nightColorCell;
    self.titleLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 10*Screen_H, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 10*Screen_H);
    self.titleLabel.frame = CGRectMake(10*Screen_W, 10*Screen_H, 250*Screen_W, 30*Screen_H);
    self.rightImageView.frame = CGRectMake(0, 45*Screen_H, 185*Screen_W, 185*Screen_H);
    self.imageView1.frame = CGRectMake(188*Screen_W, 45*Screen_H, 92*Screen_W, 91*Screen_H);
    self.imageView2.frame = CGRectMake(283*Screen_W, 45*Screen_H, 92*Screen_W, 91*Screen_H);
    self.imageView3.frame = CGRectMake(188*Screen_W, 139*Screen_H, 92*Screen_W, 91*Screen_H);
    self.imageView4.frame = CGRectMake(283*Screen_W, 139*Screen_H, 92*Screen_W, 91*Screen_H);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
