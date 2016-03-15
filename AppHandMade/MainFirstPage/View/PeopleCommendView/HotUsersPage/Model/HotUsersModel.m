//
//  HotUsersModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "HotUsersModel.h"

@implementation HotUsersModel
- (void)dealloc
{
    [_data release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
