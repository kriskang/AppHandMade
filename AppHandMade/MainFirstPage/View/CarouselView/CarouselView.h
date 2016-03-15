//
//  CarouselView.h
//  AppHandMade
//
//  Created by Kris on 15/11/12.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseView.h"

@protocol CarouselViewDelegate  <NSObject>

- (void)didClick;

@end

@interface CarouselView : BaseView

@property (nonatomic, assign) id<CarouselViewDelegate> delegate;
+(instancetype)carouselViewWithArray:(NSArray *)array carouselFrame:(CGRect)carouselFrame pageFrame:(CGRect)pageFrame;
@end
