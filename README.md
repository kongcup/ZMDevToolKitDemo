# ZMDevToolKitDemo
ZMDevToolKitDemo展示了三大功能：1.应用内文件系统查看及删除；2.NSUserDefault数据库查看；3：MagicalRecord数据库查看；

本功能的目的仅仅是方便开发和测试，用于了解App内部的数据，包括文件及文件目录和数据库中目前的数值。

使用方法：将工程中ZMDevToolKit文件夹拖到工程中，然后在需要的地方，包含头文件#import "ZMDevToolKit.h"

然后实例化一个ZMDevToolKit的对象，添加到导航控制其中即可。详细可以参考Demo。

注意：
    1.NSUserDefault数据库只能查看standardUserDefault；需要查看其他的，请自行修改源码；
    
    2.MagicalRecord数据库只能查看defaultContext;需要查看其他的，请自行修改源码；
效果图：
![image](https://github.com/kongcup/ZMDevToolKitDemo/raw/master/video.gif)

