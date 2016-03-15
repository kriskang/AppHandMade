//
//  SubjectPicListCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/20.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SubjectPicListCell.h"
#import "HeaderBase.h"
@implementation SubjectPicListCell
- (void)dealloc
{
    [_eachImageView release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.eachImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.eachImageView];
        [_eachImageView release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            
            self.backgroundColor = nightColor;
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.eachImageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
