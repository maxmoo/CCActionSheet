//
//  CCActionTableCell.m
//  CCActionSheet
//
//  Created by maxmoo on 16/3/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "CCActionTableCell.h"

@interface CCActionTableCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *iconImageView;

@end

@implementation CCActionTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(70, 10, self.boundsTableView.bounds.size.width - 140, self.bounds.size.height - 20);
    
    _titleLabel.text = self.textString;
    if (_iconImageName) {
        _iconImageView.image = [UIImage imageNamed:_iconImageName];
    }
    
    if (_sheetStyle == CCActionSheetCellStyleTextCenter) {
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _iconImageView.hidden = YES;
    }else if (_sheetStyle == CCActionSheetCellStyleIconLeft){
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _iconImageView.hidden = NO;
    }
    
}

- (void)initSubViews{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, self.bounds.size.width -140,self.bounds.size.height - 20 )];
    [self.contentView addSubview:_titleLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 32, 32)];
    _iconImageView.center = CGPointMake(30, self.bounds.size.height/2);
    [self.contentView addSubview:_iconImageView];
}

@end
