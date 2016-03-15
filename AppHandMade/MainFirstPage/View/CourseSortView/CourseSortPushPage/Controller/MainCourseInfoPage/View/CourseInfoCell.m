//
//  CourseInfoCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseInfoCell.h"
#import "HeaderBase.h"

@interface CourseInfoCell ()

@end
@implementation CourseInfoCell
- (void)dealloc
{
    [_bgImageView release];
    [_subjectLabel release];
    [_summaryLabel release];
    [_headImageView release];
    [_userNameLabel release];
    [_infoLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.bgImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView release];
        
        self.subjectLabel = [[UILabel alloc]init];
//        self.subjectLabel.backgroundColor = [UIColor blueColor];
        self.subjectLabel.textColor = [UIColor whiteColor];
        self.subjectLabel.textAlignment = NSTextAlignmentCenter;
        self.subjectLabel.font = [UIFont systemFontOfSize:23*Screen_H];
        self.subjectLabel.numberOfLines = 0;
        [self.bgImageView addSubview:self.subjectLabel];
        [_subjectLabel release];
        
        self.summaryLabel = [[UILabel alloc]init];
//        self.summaryLabel.backgroundColor = [UIColor blueColor];
        self.summaryLabel.textColor = [UIColor whiteColor];
        self.summaryLabel.textAlignment = NSTextAlignmentCenter;
        self.summaryLabel.font = [UIFont systemFontOfSize:15*Screen_H];
        self.summaryLabel.numberOfLines = 0;
        [self.bgImageView addSubview:self.summaryLabel];
        [_summaryLabel release];
        
        self.headImageView = [[UIImageView alloc]init];
//        self.headImageView.backgroundColor = [UIColor blueColor];
        self.headImageView.layer.masksToBounds = YES;
        [self.bgImageView addSubview:self.headImageView];
        [_headImageView release];
        
        
        self.userNameLabel = [[UILabel alloc]init];
//        self.userNameLabel.backgroundColor = [UIColor blueColor];
        self.userNameLabel.textColor = [UIColor whiteColor];
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgImageView addSubview:self.userNameLabel];
        [_userNameLabel release];
        
        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor blueColor];
        self.infoLabel.textColor = [UIColor whiteColor];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        [self.bgImageView addSubview:self.infoLabel];
        [_infoLabel release];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.bgImageView.frame = self.contentView.bounds;
    self.subjectLabel.frame = CGRectMake(20*Screen_W, 60*Screen_H, self.contentView.bounds.size.width - 40*Screen_W, 100*Screen_H);
    self.summaryLabel.frame = CGRectMake(20*Screen_W, 160*Screen_H, self.contentView.bounds.size.width - 40*Screen_W, 80*Screen_H);
    
    self.headImageView.frame = CGRectMake((self.contentView.bounds.size.width -60*Screen_W)/2, 320*Screen_H, 60*Screen_H, 60*Screen_H);
    self.headImageView.layer.cornerRadius = (60*Screen_H)/2;

    self.userNameLabel.frame = CGRectMake((self.contentView.bounds.size.width -220*Screen_W)/2, self.contentView.bounds.size.height -120*Screen_H, 220*Screen_W, 40*Screen_H);
    self.infoLabel.frame = CGRectMake((self.contentView.bounds.size.width -220*Screen_W)/2, self.contentView.bounds.size.height -70*Screen_H, 220*Screen_W, 40*Screen_H);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
