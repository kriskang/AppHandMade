//
//  CourseColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseColCell.h"
#import "HeaderBase.h"

@implementation CourseColCell

- (void)dealloc
{
    [_hostImageView release];
    [_subjectLabel release];
    [_userNameLabel release];
    [_infoLabel release];
    [_lineView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hostImageView = [[UIImageView alloc]init];
//        self.hostImageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.hostImageView];
        [_hostImageView release];
        
        self.subjectLabel = [[UILabel alloc]init];
//        self.subjectLabel.backgroundColor = [UIColor redColor];
        self.subjectLabel.font = [UIFont systemFontOfSize:13*Screen_H];
        self.subjectLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.subjectLabel];
        [_subjectLabel release];
        
        self.userNameLabel = [[UILabel alloc]init];
//        self.userNameLabel.backgroundColor = [UIColor yellowColor];
        self.userNameLabel.font = [UIFont systemFontOfSize:12*Screen_H];
        self.userNameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userNameLabel];
        [_userNameLabel release];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lineView];
        [_lineView release];
        
        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor blueColor];
        self.infoLabel.font = [UIFont systemFontOfSize:10*Screen_H];
        self.infoLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.infoLabel];
        [_infoLabel release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.hostImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 170*Screen_H);
    
    self.subjectLabel.frame = CGRectMake(5*Screen_W, 170*Screen_H, 160*Screen_W, 25*Screen_H);
    self.userNameLabel.frame = CGRectMake(5*Screen_W, 200*Screen_H, 160*Screen_W, 25*Screen_H);
    self.lineView.frame = CGRectMake(5*Screen_W, 228*Screen_H, 160*Screen_W, 1*Screen_H);
    self.infoLabel.frame = CGRectMake(5*Screen_W,230*Screen_H, 160*Screen_W, 15*Screen_H);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
