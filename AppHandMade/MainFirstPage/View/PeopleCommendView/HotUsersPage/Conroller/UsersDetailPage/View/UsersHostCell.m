//
//  UsersHostCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "UsersHostCell.h"
#import "HeaderBase.h"

@implementation UsersHostCell
- (void)dealloc
{
    [_hostImageView release];
    [_headImageView release];
    [_nameLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.hostImageView = [[UIImageView alloc]init];
        //self.hostImageView.backgroundColor = [UIColor redColor];
        //self.hostImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_hostImageView];
        [_hostImageView release];
        
        self.headImageView = [[UIImageView alloc]init];
        //self.headerImageView.backgroundColor = [UIColor magentaColor];
        self.headImageView.layer.masksToBounds = YES;
        [self.hostImageView addSubview:self.headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.backgroundColor = [UIColor grayColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14*Screen_H];
        [self.hostImageView addSubview:self.nameLabel];
        [_nameLabel release];
        
      
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    self.hostImageView.frame = self.contentView.bounds;
    self.headImageView.frame = CGRectMake(self.contentView.frame.size.width/2 - 50*Screen_H, 35*Screen_H, 80*Screen_H, 80*Screen_H);
    self.headImageView.layer.cornerRadius = (80*Screen_H)/2;

    self.nameLabel.frame = CGRectMake(self.contentView.frame.size.width/2 - 110*Screen_W, 120*Screen_H, 200*Screen_W, 40*Screen_H);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
