//
//  HotCourseColCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/12.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HotCourseColCell.h"
#import "HeaderBase.h"

@interface HotCourseColCell ()
@property (nonatomic, retain) UIView *lineView;
@end

@implementation HotCourseColCell

- (void)dealloc
{
    [_lineView release];
    [_hostImageView release];
    [_subjectLabel release];
    [_userName release];
    [_infoLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hostImageView = [[UIImageView alloc]init];
//        self.hostImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.hostImageView];
        [_hostImageView release];
        
        self.subjectLabel = [[UILabel alloc]init];
//        self.subjectLabel.backgroundColor = [UIColor yellowColor];
        self.subjectLabel.font = [UIFont systemFontOfSize:13*Screen_H];
        self.subjectLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.subjectLabel];
        [_subjectLabel release];
        
        self.userName = [[UILabel alloc]init];
//        self.userName.backgroundColor = [UIColor blueColor];
        self.userName.font = [UIFont systemFontOfSize:12*Screen_H];
        self.userName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userName];
        [_userName release];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lineView];
        [_lineView release];
        
        self.infoLabel = [[UILabel alloc]init];
//        self.infoLabel.backgroundColor = [UIColor greenColor];
        self.infoLabel.font = [UIFont systemFontOfSize:10*Screen_H];
        self.infoLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.infoLabel];
        [_infoLabel release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.hostImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 175*Screen_H);
    self.subjectLabel.frame = CGRectMake(10*Screen_W, 175*Screen_H, 160*Screen_W, 25*Screen_H);
    self.userName.frame = CGRectMake(10*Screen_W, 205*Screen_H, 160*Screen_W, 25*Screen_H);
    self.lineView.frame= CGRectMake(10*Screen_W, 235*Screen_H, 160*Screen_W, 1*Screen_H);
    self.infoLabel.frame = CGRectMake(10*Screen_W, 238*Screen_H, 160*Screen_W, 15*Screen_H);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
