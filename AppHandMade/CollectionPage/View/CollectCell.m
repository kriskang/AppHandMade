//
//  CollectCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/23.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CollectCell.h"
#import "HeaderBase.h"

@implementation CollectCell
- (void)dealloc
{
    [_faceImageView release];
    [_nameLabel release];
    [_bgImageView release];
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.backgroundColor = [UIColor colorWithWhite:0.600 alpha:0.804];
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.layer.cornerRadius = 5*Screen_H;
        [self.contentView addSubview:_bgImageView];
        [_bgImageView release];
        
        self.faceImageView = [[UIImageView alloc]init];
        //self.faceImageView.backgroundColor = [UIColor redColor];
        self.faceImageView.layer.masksToBounds = YES;
//        self.faceImageView.layer.cornerRadius = 25*Screen_H;
        [self.bgImageView addSubview:_faceImageView];
        [_faceImageView release];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:15*Screen_H];
        [self.bgImageView addSubview:self.nameLabel];
        [_nameLabel  release];
        
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.backgroundColor = [UIColor clearColor];
        }

        
    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.backgroundColor = [UIColor clearColor];
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.backgroundColor = [UIColor clearColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame = CGRectMake(5*Screen_W, 5*Screen_H, self.contentView.bounds.size.width-10*Screen_W, 75*Screen_H);
    self.faceImageView.frame = CGRectMake(30*Screen_W, 10*Screen_H, 50*Screen_W, 50*Screen_W);
    self.faceImageView.layer.cornerRadius = (50*Screen_W)/2;

    self.nameLabel.frame = CGRectMake(100*Screen_W, 20*Screen_H, 150*Screen_W, 35*Screen_H);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
