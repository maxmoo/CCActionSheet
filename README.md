# CCActionSheet
![项目演示](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)
![](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)
<img src="https://github.com/maxmoo/CCActionSheet/p_sheet.gif" alt="" style="max-width:100%;">
//模仿微信自定义actionSheet


//虽然很简单的一个demo，新手可以看看代码，也提供了一个不错的思路。


//两行代码实现



use:


    NSArray *array = @[@"小视频",@"拍照",@"从手机相册选择"];
    
    [[CCActionSheet shareSheet]cc_actionSheetWithSelectArray:array cancelTitle:@"取消"];
    [CCActionSheet shareSheet].delegate = self;
    
  实现协议，回调方法
  - (void)cc_actionSheetDidSelectedIndex:(NSInteger)index{
    NSLog(@"selected index:%ld",(long)index);
}
