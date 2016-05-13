# CCActionSheet
<!--![项目演示](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)-->
<!--![](https://github.com/maxmoo/CCActionSheet/p_sheet.gif)-->

CCActionSheet有两种形式的list
####下图为其一：只显示文字，处于中间位置。
<img src="https://github.com/maxmoo/CCActionSheet/blob/master/Demo/center.gif" alt="" style="max-width:100%;">
####下图为其二：显示icon和文字，文字居左对齐。
<img src="https://github.com/maxmoo/CCActionSheet/blob/master/Demo/list.gif" alt="" style="max-width:100%;">
####下面是一种特殊的显示方式，设置属性maxcount（显示的最高高度＝maxcount*cellheight），其余滑动显示。
<img src="https://github.com/maxmoo/CCActionSheet/blob/master/Demo/scroll.gif" alt="" style="max-width:100%;">

###模仿微信自定义actionSheet
实现样式是模仿微信自定义actionSheet实现的。相似度还是较高的QAQ。

###使用
####你可以使用cocoapods，也可以手动下载CCActionSheet中的文件，引用头文件#import "CCActionSheet.h"

`pod 'CCActionSheet', '~> 1.0.1'`


回调方式使用了两种，这里只举例使用block回调。

`初始化`
>
    CCActionSheet *sheet = [[CCActionSheet alloc] initWithTitle:@"这是CCActionSheet" clickedAtIndex:^(NSInteger index) {
        NSLog(@"selected: %ld",(long)index);
    } cancelButtonTitle:@"取消" otherButtonTitles:@"我是第1个选择",@"我是第2个选择",@"我是第3个选择",@"我是第4个选择",@"我是第5个选择",@"我是第6个选择",@"我是第7个选择",nil];
>    
`设置样式`
>
    sheet.style = CCActionSheetStyleTextCenter;
>
`设置显示最多cell数`
>
    sheet.maxCount = 5;
>
`设置list形式下的icon，现在只能以字符串数组传入😄`
>
    sheet.iconImageNameArray = @[@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected",@"icon_connected"];
>
`显示`   
>
    [sheet show];
>

####最后需要感谢[这位前辈](https://github.com/docee/PQActionSheet),因为之前自己是使用UIButton来实现的，现在完成的这个版本其中很大一部分是借鉴他的，在此表示感谢🙏！

也可以到我的个人博客中查看一些细节：[http://www.justonecode.com](http://www.maxmoo.me)。
