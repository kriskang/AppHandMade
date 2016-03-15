//
//  CenterBtnView.h
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseView.h"

@interface CenterBtnView : BaseView
@property (nonatomic, copy) void (^centerBtnBlock)(NSString *, NSString *);
@end
