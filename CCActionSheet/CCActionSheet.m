//
//  CCActionSheet.m
//  CCActionSheet
//
//  Created by maxmoo on 16/1/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "CCActionSheet.h"

#define CC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define cellHeight 45

@interface CCActionSheet()

@property (nonatomic, strong) UIWindow *sheetWindow;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSString *cancelString;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation CCActionSheet

+ (instancetype)shareSheet{
    static id shareSheet;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareSheet = [[[self class] alloc] init];
    });
    return shareSheet;
}

- (void)cc_actionSheetWithSelectArray:(NSArray *)array cancelTitle:(NSString *)cancel{
    
    self.selectArray = [NSArray arrayWithArray:array];
    self.cancelString = cancel;
    
    if (!_sheetWindow) {
        [self initSheetWindow];
    }
    _sheetWindow.hidden = NO;
    
    [self showSheetWithAnimation];
}

- (void)initSheetWindow{
    _sheetWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, CC_SCREEN_WIDTH, CC_SCREEN_HEIGHT)];
    _sheetWindow.windowLevel = UIWindowLevelStatusBar;
    _sheetWindow.backgroundColor = [UIColor clearColor];
    
    _sheetWindow.hidden = YES;

    //zhezhao
    _backView = [[UIView alloc] initWithFrame:_sheetWindow.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.0;
    [_sheetWindow addSubview:_backView];
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    _tapGesture.numberOfTapsRequired = 1;
    [_backView addGestureRecognizer:_tapGesture];
    
    UIView *selectView = [self creatSelectButton];
    
    [_sheetWindow addSubview:selectView];
}


- (void)showSheetWithAnimation{
    CGFloat viewHeight = cellHeight * (self.selectArray.count+1) + 5 + (self.selectArray.count - 2) * 2;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sheetView.frame = CGRectMake(0, CC_SCREEN_HEIGHT - viewHeight, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.2;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidSheetWithAnimation{
    CGFloat viewHeight = cellHeight * (self.selectArray.count+1) + 5 + (self.selectArray.count - 2) * 2;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sheetView.frame = CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self hidActionSheet];
    }];
}

- (UIView *)creatSelectButton{
    CGFloat viewHeight = cellHeight * (self.selectArray.count+1) + 5 + (self.selectArray.count - 2) * 2;
    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight)];
    _sheetView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    for (int i = 0; i < self.selectArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i * (cellHeight+1), CC_SCREEN_WIDTH, cellHeight);
        [button setTitle:[NSString stringWithFormat:@"%@",self.selectArray[i]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1001+i;
        [_sheetView addSubview:button];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, viewHeight - cellHeight, CC_SCREEN_WIDTH, cellHeight);
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:[NSString stringWithFormat:@"%@",self.cancelString] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 1000;
    [_sheetView addSubview:cancelButton];
    
    return _sheetView;
}

- (void)buttonSelectAction:(UIButton *)btn{
    UIButton *button = (UIButton *)btn;
    NSInteger index = button.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_actionSheetDidSelectedIndex:)]) {
        [self.delegate cc_actionSheetDidSelectedIndex:index];
    }
    [self hidSheetWithAnimation];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self hidSheetWithAnimation];
}

- (void)hidActionSheet{
    _sheetWindow.hidden = YES;
    _sheetWindow = nil;
}

@end
