# EMDemo
环信IM 2.x / 未实现离线推送 / 



 1.     注册成为环信的开发者

 2.     在开发者后台创建APP获取Key

 3.     制作并上传推送证书  ( 如果需要实现离线推送功能需要制作证书 , 咋环信开发者文档中有相应的步骤)

     再此, 下载环信SDK并集成 
          或者使用pod集成到项目中
          
          pod 'EaseMobSDKFull', :git => 'https://github.com/easemob/sdk-ios-cocoapods-integration.git'


 4.     导入工程, 添加依赖库

 5.     向 Build Settings → Linking → Other Linker Flags 中添加 -ObjC

 6.     修改AppDelegate  ( 按照官方文档修改 )
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1189170704178205#emdemo" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}



 

 
 
 
 ------------------实现的功能------------------------
 ( 所有功能实现详见demo及环信IM官方文档 http://docs.easemob.com/start/300iosclientintegration/30iossdkbasic)
 
  0.因SDK中打印了很多SDK里面打印的日志, 所以在AppDelegate的didFinishLaunchingWithOptions中 换用另一个方法, 就可以屏蔽其中的打印日志
 
   [[EaseMob sharedInstance] registerSDKWithAppKey:@"1189170704178205#emdemo" apnsCertName:nil  otherConfig:@{kSDKConfigEnableConsoleLogger:@(NO)}];


  1.注册 和 登录 使用的是block异步方法
 
  2.自动登录
 
  3.监听网络状态并自动重连
 
  4.添加好友, 好友列表
     buddyList需要自动登录后才有值, 是本地数据库获取的好友列表数据
     需要从服务器获取好友列表
     [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
     
   
  5.接收到好友的同意请求后, 刷新好友列表数据

  6.删除好友
  
  7.退出登录
  

