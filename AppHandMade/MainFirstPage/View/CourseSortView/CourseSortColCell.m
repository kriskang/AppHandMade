//
//  CourseSortColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseSortColCell.h"
#import "HeaderBase.h"


@implementation CourseSortColCell
- (void)dealloc
{
    [_sortImageView release];
    [_sortTitleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.sortImageView = [[UIImageView alloc]init];
//        self.sortImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.sortImageView];
        [_sortImageView release];
        
        self.sortTitleLabel = [[UILabel alloc]init];
//        self.sortTitleLabel.backgroundColor = [UIColor brownColor];
        self.sortTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.sortTitleLabel setFont:[UIFont systemFontOfSize:12*Screen_H]];
        [self.contentView addSubview:self.sortTitleLabel];
        [_sortTitleLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.sortTitleLabel.textColor = [UIColor whiteColor];
        }


    }
    return self;
}

- (void)changeColor:(NSNotification *)notification
{
    self.sortTitleLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.sortTitleLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.sortImageView.frame = CGRectMake(30*Screen_W, 20*Screen_H, 35*Screen_W, 35*Screen_H);
    self.sortTitleLabel.frame = CGRectMake(20*Screen_W, 65*Screen_H, 55*Screen_W, 18*Screen_H);


}



//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.sortImageView.frame = CGRectMake(30, 20, 35, 35);
//    self.sortTitleLabel.frame = CGRectMake(20, 65, 55, 18);
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
