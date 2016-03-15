//
//  ClassCell.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "ClassCell.h"
#import "ClassModel.h"
#import "UIImageView+WebCache.h"

@interface ClassCell ()
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation ClassCell
- (void)dealloc
{
    [_bgImageView release];
    [_titleLabel release];
    [_model release];
    [super dealloc];
}

/** 重写tableViewCell初始化方法并添加子控件 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgImageView = [[UIImageView alloc] init];
//        self.bgImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:0.500];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
    }
    return self;
}

/** tableViewCell布局 此方法内进行子控件布局*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame = self.contentView.frame;
    self.titleLabel.frame = CGRectMake(0, self.contentView.frame.size.height / 1.25, self.contentView.frame.size.width, self.contentView.frame.size.height / 5 );
}

/** 重写model的setter方法 给子控件赋数据 */
- (void)setModel:(ClassModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.titleLabel.text = model.subject;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.class_image] placeholderImage:[UIImage imageNamed:@"hand"]];
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
