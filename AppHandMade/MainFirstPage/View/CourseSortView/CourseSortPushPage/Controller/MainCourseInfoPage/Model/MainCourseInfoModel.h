//
//  MainCourseInfoModel.h
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseModel.h"

@interface MainCourseInfoModel : BaseModel
@property (nonatomic, retain) NSString *host_pic;

@property (nonatomic, retain) NSString *host_pic_m;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) NSString *face_pic;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSString *view;
@property (nonatomic, retain) NSString *collect;
@property (nonatomic, retain) NSString *comment_num;
@property (nonatomic, retain) NSString *laud;

@property (nonatomic, retain) NSMutableArray *material;
@property (nonatomic, retain) NSMutableArray *tools;

@property (nonatomic, retain) NSMutableArray *step;


@end
