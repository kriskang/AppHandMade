//
//  LeadViewController.h
//  AppHandMade
//
//  Created by Kris on 15/11/25.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseViewController.h"

@interface LeadViewController : BaseViewController
@property (nonatomic, copy) void(^leadBlock)(void);

@end
