//
//  CCActionSheet.m
//  CCActionSheet
//
//  Created by maxmoo on 16/3/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "CCActionSheet.h"
#import "CCActionTableCell.h"

//@brief 按钮的高度
#define ACTION_SHEET_BTN_HEIGHT 45.0f
#define SHADOW_HEIGHT   5.0f
@interface CCActionSheet () <UITableViewDelegate,UITableViewDataSource>

@property (copy,nonatomic) ClickedIndexBlock block;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *backgroundView;

@property (strong,nonatomic) NSMutableArray *otherButtons;

@property (assign,nonatomic) CGFloat tableViewHeight;
@property (assign,nonatomic) NSInteger buttonCount;

@property (strong,nonatomic) UIView *customView;

@end

@implementation CCActionSheet

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<CCActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        self.titleText = [title copy];
        self.cancelText = [cancelButtonTitle copy];
        self.delegate = delegate;
        
        self.otherButtons = [[NSMutableArray alloc]init];
        
        
        // 获取可变参数
        [_otherButtons addObject:otherButtonTitles];
        va_list list;
        NSString *curStr;
        va_start(list, otherButtonTitles);
        while ((curStr = va_arg(list, NSString *))) {
            
            [_otherButtons addObject:curStr];
            
        }
        
        //初始化子视图
        [self installSubViews];
        
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
               clickedAtIndex:(ClickedIndexBlock)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        self.titleText = [title copy];
        self.cancelText = [cancelButtonTitle copy];
        self.block = block;
        
        self.otherButtons = [[NSMutableArray alloc]init];
        
        
        // 获取可变参数
        [_otherButtons addObject:otherButtonTitles];
        va_list list;
        NSString *curStr;
        va_start(list, otherButtonTitles);
        while ((curStr = va_arg(list, NSString *))) {
            
            [_otherButtons addObject:curStr];
            
        }
        
        //初始化子视图
        [self installSubViews];
        
    }
    return self;
}

//添加自定义视图
- (instancetype)initWithCustomView:(UIView *)customView{
    self = [super init];
    if (self) {
        self.customView = customView;
        [self installSubViews];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Public Method

/**
 *  @brief 显示ActionSheet
 */
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    self.tableView.frame = CGRectMake(0.0f,self.bounds.size.height, self.bounds.size.width, self.tableViewHeight);
    NSLog(@"%@",self.tableView);
    __weak typeof(self) weakSelf = self;
    
    if([_delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        
        [_delegate willPresentActionSheet:weakSelf];
        
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = weakSelf.tableView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height - self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        
        weakSelf.backgroundView.alpha = 0.3f;
        
    } completion:^(BOOL finished) {
        
        
        if([_delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
            
            [_delegate didPresentActionSheet:weakSelf];
            
        }
        
        
    }];
}

/**
 *  @brief 隐藏ActionSheet
 */
-(void)hide
{
    __weak typeof(self) weakSelf = self;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.tableView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height + self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        weakSelf.backgroundView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        
    }];
}

/**
 *  @brief 添加按钮
 *
 *  @param title 按钮标题
 *
 *  @return 按钮的Index
 */
- (NSInteger)addButtonWithTitle:(NSString *)title {
    
    [self.otherButtons addObject:[title copy]];
    
    return self.otherButtons.count - 1;
    
}

#pragma mark - Private

/**
 *  @brief 初始化子视图
 */
- (void)installSubViews {
    
    self.frame = [UIScreen mainScreen].bounds;
    
    // 初始化遮罩视图
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.142 alpha:1.000];
    self.backgroundView.alpha = 0.0f;
    [self addSubview:_backgroundView];
    
    
    // 初始化TableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_tableView];
    
    // TableView加上高斯模糊效果
    if (NSClassFromString(@"UIVisualEffectView") && !UIAccessibilityIsReduceTransparencyEnabled()) {
        self.tableView.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [blurEffectView setFrame:CGRectMake(0,0, self.bounds.size.width, self.tableViewHeight)];
        
        self.tableView.backgroundView = blurEffectView;
    }
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
    
    
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
}

#pragma mark - Util
/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
-(UIImage *)imageWithUIColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIView *)selectedView{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, ACTION_SHEET_BTN_HEIGHT)];
    
    view.image = [self imageWithUIColor:[UIColor lightGrayColor]];
    
    
    return view;
}


#pragma mark - GET/SET

/**
 *  @brief TableView高度
 *
 *  @return TableView高度
 */
-(CGFloat)tableViewHeight {
    
    if (self.customView) {
        NSLog(@"%f",self.customView.bounds.size.height);
        return self.customView.bounds.size.height;
    }
    
    CGFloat tableHeight = 0.0f;
    
    if (_maxCount) {
        if (self.buttonCount > _maxCount) {
            tableHeight = ACTION_SHEET_BTN_HEIGHT * _maxCount;
        }else{
            tableHeight = self.buttonCount * ACTION_SHEET_BTN_HEIGHT;
        }
    }else{
        tableHeight = self.buttonCount * ACTION_SHEET_BTN_HEIGHT;
    }
  
    if (@available(iOS 11.0, *)) {
        CGFloat a =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        if (a > 0) {
            tableHeight += a;
        }
    }
  
    if (self.cancelText) {
        return tableHeight+SHADOW_HEIGHT;
    }else{
       return tableHeight;
    }
}


/**
 *  @brief 按钮的总个数(包括Title和取消)
 *
 *  @return 按钮的总个数
 */
-(NSInteger)buttonCount {
    
    NSInteger count = 0;
    if(self.titleText && ![@"" isEqualToString:self.titleText]) {
        count+=1;
    }
    
    if(self.cancelText && ![@"" isEqualToString:self.cancelText]) {
        count+=1;
    }
    
    count+=self.otherButtons.count;
    
    
    return count;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.customView) {
        return self.customView.bounds.size.height;
    }
    
    return ACTION_SHEET_BTN_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.customView) {
        return 0.0f;
    }
    
    if(section == 0 && self.titleText) {
        
        return ACTION_SHEET_BTN_HEIGHT;
        
    }
    
    if(section == 1 && self.cancelText) {
        
        return 5.0f;
        
    }
    
    return 0.0f;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section == 0 && self.titleText) {
        
        UILabel *label = [[UILabel alloc]init];
        [label setFont:[UIFont systemFontOfSize:15.0f]];
        [label setText:self.titleText];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [label setAdjustsFontSizeToFitWidth:YES];

        if (NSClassFromString(@"UIVisualEffectView") && !UIAccessibilityIsReduceTransparencyEnabled()) {
            label.backgroundColor = [UIColor clearColor];
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            [blurEffectView setFrame:CGRectMake(0,0, self.tableView.bounds.size.width, ACTION_SHEET_BTN_HEIGHT)];
            
            [label addSubview:blurEffectView];
        }
        
        
        UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor darkGrayColor]]];
        sepLine.frame = CGRectMake(0, ACTION_SHEET_BTN_HEIGHT - 0.3f, self.tableView.bounds.size.width, 0.3f);
        [label addSubview:sepLine];
        
        return label;
    }
    
    
    if(section == 1 && self.cancelText) {
        
        UIView *view = [[UIView alloc] init];
        
        UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor grayColor]]];
        sepLine.frame = CGRectMake(0,SHADOW_HEIGHT-0.3f, self.tableView.bounds.size.width, 0.3f);
        [view addSubview:sepLine];
        
        return view;
        
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = self.otherButtons.count;
    
    if(indexPath.section == 0) {
        index = indexPath.row;
    }
    
    
    // 委托方式返回结果
    if([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        
        [_delegate actionSheet:self clickedButtonAtIndex:index];
        
    }
    
    // Block方式返回结果
    if(self.block) {
        
        self.block(index);
        
    }
    
    [self hide];
    
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"actionsheetCell";
    
    CCActionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        
        cell = [[CCActionTableCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identify];
        
        if (NSClassFromString(@"UIVisualEffectView") ) {
            cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        }

        cell.layer.masksToBounds = YES;
        if (self.style) {
            cell.sheetStyle = (CCActionSheetCellStyle)self.style;
        }
        cell.boundsTableView = self.tableView;
        
        if (!self.customView) {
            // 加上分割线
            UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor grayColor]]];
            sepLine.frame = CGRectMake(0, ACTION_SHEET_BTN_HEIGHT - 0.3f, [UIScreen mainScreen].bounds.size.width, 0.3f);
            [sepLine setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [cell addSubview:sepLine];
        }
    }
    
    if(indexPath.section == 0){
        if (indexPath.row == 0 && self.customView) {
            self.customView.center = CGPointMake(self.tableView.bounds.size.width/2,self.tableView.bounds.size.height/2);
            [cell.contentView addSubview:self.customView];
        }
        if (_iconImageNameArray.count > indexPath.row) {
            cell.iconImageName = _iconImageNameArray[indexPath.row];
        }
        cell.textString = self.otherButtons[indexPath.row];
    }
    
    if(indexPath.section == 1){
        if (_iconImageNameArray.count > self.otherButtons.count) {
            cell.iconImageName = [_iconImageNameArray lastObject];
        }
        cell.textString = self.cancelText;
    }
    
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(self.cancelText) {
        
        return 2;
        
    }
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.customView) {
        return 1;
    }
    
    if(section == 0) {
        
        return self.otherButtons.count;
        
    }
    
    if(section == 1 && self.cancelText) {
        
        return 1;
        
    }
    
    return 0;
    
}


#pragma mark - Observer

// 监听屏幕旋转方向
-(void)statusBarOrientationChange:(NSNotification *)notification {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    // iOS8以下宽高不会自动交换
    if(orientation != UIInterfaceOrientationPortrait) {
        
        if([UIDevice currentDevice].systemVersion.floatValue < 8.0f) {
            
            self.frame = CGRectMake(0, 0, screenSize.height, screenSize.width);
            
        }
    }
    
    self.backgroundView.frame = self.frame;
    
    CGRect tableViewRect = self.tableView.frame;
    
    if(orientation == UIInterfaceOrientationPortrait) {
        tableViewRect.origin.y+=fabs(screenSize.height-screenSize.width);
    }else {
        tableViewRect.origin.y = self.frame.size.height - self.tableViewHeight;
    }
    
    
    self.tableView.frame = tableViewRect;
    
    [self.tableView reloadData];
    
}

@end

