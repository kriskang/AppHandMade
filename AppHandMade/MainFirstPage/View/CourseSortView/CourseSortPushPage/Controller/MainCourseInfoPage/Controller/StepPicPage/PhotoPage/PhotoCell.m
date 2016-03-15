//
//  PhotoCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
- (void)dealloc
{
    [_bgImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.backgroundColor = [UIColor blackColor];
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_bgImageView];
        [_bgImageView release];
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.bgImageView.frame = CGRectMake(0, 20, self.contentView.bounds.size.width, self.contentView.bounds.size.height-100);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
