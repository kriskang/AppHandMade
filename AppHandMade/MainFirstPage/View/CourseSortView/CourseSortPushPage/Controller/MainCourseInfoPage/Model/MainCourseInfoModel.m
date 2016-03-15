//
//  MainCourseInfoModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "MainCourseInfoModel.h"

@implementation MainCourseInfoModel
- (void)dealloc
{
    [_host_pic release];
    [_host_pic_m release];
    [_subject release];
    [_summary release];
    [_face_pic release];
    [_user_name release];
    [_view release];
    [_collect release];
    [_comment_num release];
    [_laud release];
    [_material release];
    [_tools release];
    [_step release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
