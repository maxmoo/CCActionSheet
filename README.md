# CCActionSheet
<!--![项目演示](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)-->
<!--![](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)-->

<img src="https://github.com/maxmoo/CCActionSheet/blob/master/p_sheet2.gif" alt="" style="max-width:100%;">



//模仿微信自定义actionSheet


//虽然很简单的一个demo，新手可以看看代码，也提供了一个不错的思路。


//一行代码实现



use:


    NSArray *array = @[@"小视频",@"拍照",@"从手机相册选择"];
    [[CCActionSheet shareSheet]cc_actionSheetWithSelectArray:array cancelTitle:@"取消" delegate:self];
    
  实现协议，回调方法
>
- (void)cc_actionSheetDidSelectedIndex:(NSInteger)index{
    NSLog(@"selected index:%ld",(long)index);
}
>
也可以到我的个人博客中查看一些细节：[http://www.justonecode.com](http://www.justonecode.com)。
