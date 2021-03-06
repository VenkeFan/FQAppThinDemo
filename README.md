# FQAppThinDemo

iOS瘦身实战

参考链接：
https://juejin.im/post/5d6482b0e51d456209238885

https://mp.weixin.qq.com/s?__biz=MzAwNDY1ODY2OQ==&mid=207986417&idx=1&sn=77ea7d8e4f8ab7b59111e78c86ccfe66&3rd=MzA3MDU4NTYzMw==&scene=6#rd

https://blog.csdn.net/olsQ93038o99S/article/details/100680143

__objc_classrefs 是引用到的类， __objc_classname 是所有类名，通过分析两者之间的差别，就可以知道哪些类没有用到。
同理，分析 __objc_selrefs 和 __objc_methname 的差别，也可知道哪些方法没用到。
由于OC是动态语言，中间可能会出现判断失误的情况。

1. 首先生成 LinkMap 文件：设置Project->Build Settings->Write Link Map File为YES，并设置Path to Link Map File，build完后就可以在设置的路径看到LinkMap文件
2. 打开项目 Products->Show in Finder，终端进入 /FQAppThinDemo.app 路径
3. 查找无用selector：
	
	1). 查找引用到的方法：
	使用 “otool -v -s __DATA __objc_selrefs FQAppThinDemo” 命令输出 __DATA __objc_selrefs 段的信息，得到所有使用到的方法（包括实例方法与类方法）:
	FQAppThinDemo:
	Contents of (__DATA,__objc_selrefs) section
	0000000100005468  __TEXT:__objc_methname:viewDidLoad
	0000000100005470  __TEXT:__objc_methname:sayGoodbye
	0000000100005478  __TEXT:__objc_methname:run
	0000000100005480  __TEXT:__objc_methname:role
	0000000100005488  __TEXT:__objc_methname:initWithName:sessionRole:

	对比 FQAppThinDemo-LinkMap-normal-x86_64.txt

	文件中的 # Sections: 部分：
	0x100005468	0x00000028	__DATA	__objc_selrefs

	以及 # Symbols: 部分：
	0x100005468	0x00000008	[  2] pointer-to-literal-cstring
	0x100005470	0x00000008	[  2] pointer-to-literal-cstring
	0x100005478	0x00000008	[  2] pointer-to-literal-cstring
	0x100005480	0x00000008	[  3] pointer-to-literal-cstring
	0x100005488	0x00000008	[  3] pointer-to-literal-cstring

	可以看到每个方法的位置偏移量是一一对应的。

	2). 同理，查找所有的方法：
	使用 “otool -v -s __TEXT __objc_methname FQAppThinDemo” 命令

	3). 二者结果对比，可以得到未使用的方法，不过因为OC的语言特性，可以动态调用方法，所以这一步还需要排除有没有使用 performSelector: 等的调用

4. 查找无用的类
	
	1).使用 “otool -oV FQAppThinDemo” 输出可执行文件的详细信息

	2). “otool -v -s __DATA __objc_classrefs FQAppThinDemo“ 输出如下：
	FQAppThinDemo:
	Contents of (__DATA,__objc_classrefs) section
	0000000100005490	80 55 00 00 01 00 00 00 00 00 00 00 00 00 00 00 
	00000001000054a0	30 55 00 00 01 00 00 00 

	对比第一步中输出的 __objc_classrefs 部分：
	Contents of (__DATA,__objc_classrefs) section
	0000000100005490 0x100005580 _OBJC_CLASS_$_Person
	0000000100005498 0x0 _OBJC_CLASS_$_UISceneConfiguration
	00000001000054a0 0x100005530 _OBJC_CLASS_$_AppDelegate
	
	3). “otool -v -s __DATA_CONST __objc_classlist FQAppThinDemo” 输出如下：
	FQAppThinDemo:
	Contents of (__DATA_CONST,__objc_classlist) section
	00000001000030b8	b8 54 00 00 01 00 00 00 30 55 00 00 01 00 00 00 
	00000001000030c8	80 55 00 00 01 00 00 00 d0 55 00 00 01 00 00 00 

	对比第一步中输出的 __objc_classrefs 部分：

	4). “otool -v -s __TEXT __objc_classname FQAppThinDemo” 输出如下：
	FQAppThinDemo:
	Contents of (__TEXT,__objc_classname) section
	0000000100002204  ViewController
	0000000100002213  AppDelegate
	000000010000221f  UIApplicationDelegate
	0000000100002235  NSObject
	000000010000223e  Person
	0000000100002245  SceneDelegate
	0000000100002253  UIWindowSceneDelegate
	0000000100002269  UISceneDelegate
	0000000100002279  \001






















