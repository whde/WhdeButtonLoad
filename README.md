## WhdeButtonLoad
- 当程序在点击UIButton之后请求网络数据，请求网络需要时间，在这个时间里，我们需要做到更极致的用户体验;
- 使用<code>**WhdeButtonLoad**</code>将会在这时间里会在Button上显示LoadingView，在完成之后，会恢复原状态;
![](https://raw.githubusercontent.com/whde/WhdeButtonLoad/master/Screen.gif)

```objective-c
pod 'WhdeButtonLoad', '~> 1.0.0'
```

```objective-c
#import <WhdeButtonLoad/WhdeButtonLoad.h>
```
或者
```objective-c
#import "UIButtonLoad.h"
```
```objective-c
UIButtonLoad *btn = [UIButtonLoad buttonWithType:UIButtonTypeCustom];
[btn addAction:^(UIButtonLoad *btn) {
    NSLog(@"start");
    // 伪装网络加载所需要的时间
    __block int timeout= 2;
    __block UIButtonLoad *wsendCodeBtn = btn;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout< 0){
            dispatch_source_cancel(timer);
            // 网络请求完成，还原初始状态
            [wsendCodeBtn finished];
            NSLog(@"finished");
        } else {
            NSLog(@"%d", timeout);
            timeout--;
        }
    });
    dispatch_resume(timer);
    // 伪装网络加载时间

}];
[btn setBackgroundImage:[UIImage imageNamed:@"29pt@3x"] forState:UIControlStateNormal];
btn.frame = CGRectMake(0, 0, 300, 150);
btn.center = self.view.center;
btn.backgroundColor = [UIColor greenColor];
[self.view addSubview:btn];
```

