//
//  LeftBtnView.h
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseView.h"

@interface LeftBtnView : BaseView
@property (nonatomic, copy) void (^leftBtnBlock)(NSString *, NSString *);
@end
