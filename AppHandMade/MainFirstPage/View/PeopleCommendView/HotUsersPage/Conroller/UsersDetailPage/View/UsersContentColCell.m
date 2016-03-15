//
//  UsersContentColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UsersContentColCell.h"
#import "HeaderBase.h"

@implementation UsersContentColCell
- (void)dealloc
{
    [_hostImageView release];
    [_titleLabel release];
    [_infoLabel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hostImageView = [[UIImageView alloc]init];
        //self.hostImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.hostImageView];
        [_hostImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
        //self.titleLable.backgroundColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.infoLabel = [[UILabel alloc]init];
        //self.likeLable.backgroundColor = [UIColor orangeColor];
        self.infoLabel.font = [UIFont systemFontOfSize:11];
        self.infoLabel.textAlignment = NSTextAlignmentLeft;
        self.infoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.infoLabel];
        [_infoLabel release];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.contentView.backgroundColor = nightColorCell;
            self.titleLabel.textColor = [UIColor whiteColor];
            self.infoLabel.textColor = [UIColor whiteColor];
        }
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.contentView.backgroundColor = nightColorCell;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.infoLabel.textColor = [UIColor whiteColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.infoLabel.textColor = [UIColor blackColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.hostImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height -60);
    self.titleLabel.frame = CGRectMake(5, self.contentView.bounds.size.height-58, self.contentView.bounds.size.width -10, 30);
    self.infoLabel.frame = CGRectMake(5, self.contentView.bounds.size.height-26, self.contentView.bounds.size.width -10, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
