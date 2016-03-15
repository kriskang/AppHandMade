//
//  CourseToolsColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseToolsColCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]


@implementation CourseToolsColCell
- (void)dealloc
{
    [_nameLabel release];
    [_numLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = secondColor;
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self.contentView addSubview:self.nameLabel];
        [_nameLabel release];
        
        
        
        self.numLabel = [[UILabel alloc]init];
        self.numLabel.backgroundColor = [UIColor whiteColor];
        self.numLabel.font = [UIFont systemFontOfSize:14*Screen_H];
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
            self.nameLabel.backgroundColor = nightColorCell;
            self.numLabel.backgroundColor = nightColorCell;
            self.nameLabel.textColor = [UIColor whiteColor];
            self.numLabel.textColor = [UIColor whiteColor];
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColor;
    self.nameLabel.backgroundColor = nightColorCell;
    self.numLabel.backgroundColor = nightColorCell;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.numLabel.textColor = [UIColor whiteColor];

    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = secondColor;
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.numLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.numLabel.textColor = [UIColor blackColor];

    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{

    self.nameLabel.frame = CGRectMake(0, 0, self.contentView.bounds.size.width / 2 - 1*Screen_W, self.contentView.bounds.size.height - 2*Screen_W);
    self.numLabel.frame = CGRectMake(self.contentView.bounds.size.width / 2 + 1*Screen_W, 0, self.contentView.bounds.size.width / 2 - 1*Screen_W, self.contentView.bounds.size.height - 2*Screen_W);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
