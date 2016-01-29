# CCActionSheet
//模仿微信自定义actionSheet
//两行代码实现
use:
    NSArray *array = @[@"小视频",@"拍照",@"从手机相册选择"];
    [[CCActionSheet shareSheet]cc_actionSheetWithSelectArray:array cancelTitle:@"取消"];
    [CCActionSheet shareSheet].delegate = self;
    
  实现协议，回调方法
  - (void)cc_actionSheetDidSelectedIndex:(NSInteger)index{
    NSLog(@"selected index:%ld",(long)index);
}
