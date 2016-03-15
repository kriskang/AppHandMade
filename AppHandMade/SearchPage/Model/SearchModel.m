//
//  SearchModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/21.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
- (void)dealloc
{
    [_course_data release];
    [_user_data release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
