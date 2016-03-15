//
//  ActivityIntroductionCell.h
//  AppHandMade
//
//  Created by Kris on 15/11/18.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import <WebKit/WebKit.h>

@interface ActivityIntroductionCell : BaseCollectionViewCell
@property (nonatomic, retain) WKWebView *webView;
@end
