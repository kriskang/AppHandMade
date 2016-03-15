//
//  TitleBarReusableView.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "TitleBarReusableView.h"
#import "HeaderBase.h"

@implementation TitleBarReusableView
- (void)dealloc
{
    [_titleBarLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleBarLabel = [[UILabel alloc]init];
//        self.titleBarLabel.backgroundColor = [UIColor purpleColor];
        self.titleBarLabel.textAlignment = NSTextAlignmentLeft;
        [self.titleBarLabel setFont:[UIFont systemFontOfSize:14*Screen_H]];
        [self addSubview:self.titleBarLabel];
        [_titleBarLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.backgroundColor = nightColor;
            self.titleBarLabel.textColor = [UIColor whiteColor];
        }
        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.backgroundColor = nightColor;
    self.titleBarLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleBarLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.titleBarLabel.frame = layoutAttributes.bounds;
//    NSLog(@"%@", NSStringFromCGRect(layoutAttributes.frame));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
