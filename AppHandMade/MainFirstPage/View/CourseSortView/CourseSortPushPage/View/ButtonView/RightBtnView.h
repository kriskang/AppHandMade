//
//  RightBtnView.h
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseView.h"

@interface RightBtnView : BaseView
@property (nonatomic, copy) void (^rightBtnBlock)(NSString *, NSString *);
@end
