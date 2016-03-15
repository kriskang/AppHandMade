//
//  CourseModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel
- (void)dealloc
{
    [_data release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
