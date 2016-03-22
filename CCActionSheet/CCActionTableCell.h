//
//  CCActionTableCell.h
//  CCActionSheet
//
//  Created by maxmoo on 16/3/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CCActionSheetCellStyleTextCenter = 0,
    CCActionSheetCellStyleIconLeft,
} CCActionSheetCellStyle;

@interface CCActionTableCell : UITableViewCell

@property (assign, nonatomic)NSString *iconImageName;
@property (assign, nonatomic)NSString *textString;
@property (assign, nonatomic)CCActionSheetCellStyle sheetStyle;
@property (strong, nonatomic)UITableView *boundsTableView;

@end
