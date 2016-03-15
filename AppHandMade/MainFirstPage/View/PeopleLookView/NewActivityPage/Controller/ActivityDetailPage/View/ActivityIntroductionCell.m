//
//  ActivityIntroductionCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "ActivityIntroductionCell.h"



@implementation ActivityIntroductionCell
- (void)dealloc
{
    [_webView release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[WKWebView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.webView];
        [_webView release];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{

    self.webView.frame = self.contentView.bounds;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
