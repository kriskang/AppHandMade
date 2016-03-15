//
//  SubjectPicListModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/20.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "SubjectPicListModel.h"

@implementation SubjectPicListModel
- (void)dealloc
{
    [_course release];
    [_subject release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
