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
    NSArray *array = @[@"小视频",@"拍照",@"从手机相册选择"];
    [[CCActionSheet shareSheet]cc_actionSheetWithSelectArray:array cancelTitle:@"取消" delegate:self];
}

- (void)cc_actionSheetDidSelectedIndex:(NSInteger)index{
    NSLog(@"selected index:%ld",(long)index);
}

@end
