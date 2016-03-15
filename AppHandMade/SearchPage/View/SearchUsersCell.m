//
//  SearchUsersCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/21.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SearchUsersCell.h"
#import "HeaderBase.h"

@implementation SearchUsersCell
- (void)dealloc
{
    [_headImageView release];
    [_nameLabel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headImageView = [[UIImageView alloc]init];
//        self.headImageView.backgroundColor = [UIColor yellowColor];
        self.headImageView.layer.masksToBounds = YES;
       
        [self.contentView addSubview:self.headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:14*Screen_H];
//        self.nameLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.nameLabel];
        [_nameLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColorCell;
            self.nameLabel.textColor = [UIColor whiteColor];
        }
        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.backgroundColor = nightColorCell;
    self.nameLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}


-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.headImageView.frame = CGRectMake(5*Screen_W, 5*Screen_H, 50*Screen_H, 50*Screen_H);
    self.headImageView.layer.cornerRadius = (50*Screen_H)/2;
    
    self.nameLabel.frame = CGRectMake(65*Screen_W, 10*Screen_H, 150*Screen_W, 40*Screen_H);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
