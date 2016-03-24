//
//  ViewController.m
//  CCActionSheet
//
//  Created by maxmoo on 16/1/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ViewController.h"
#import "CCActionSheet.h"


@interface ViewController ()<CCActionSheetDelegate>
- (IBAction)showCCActionSheet:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"IMG_0477"];
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCCActionSheet:(UIButton *)sender {
    
    CCActionSheet *sheet = [[CCActionSheet alloc] initWithTitle:@"这是CCActionSheet" clickedAtIndex:^(NSInteger index) {
        NSLog(@"selected: %ld",(long)index);
    } cancelButtonTitle:@"取消" otherButtonTitles:@"我是第1个选择",@"我是第2个选择",@"我是第3个选择",@"我是第4个选择",@"我是第5个选择",@"我是第6个选择",@"我是第7个选择",nil];
    
    sheet.style = CCActionSheetStyleTextCenter;
    
    sheet.maxCount = 5;
    
    sheet.iconImageNameArray = @[@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected"];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 50, 30);
//    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"click" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
    
    
    
//    CCActionSheet *sheet = [[CCActionSheet alloc] initWithCustomView:view];

    [sheet show];
}

- (void)buttonClicked{
    NSLog(@"11111");
}

- (void)cc_actionSheetDidSelectedIndex:(NSInteger)index{
    NSLog(@"selected index:%ld",(long)index);
}

@end
