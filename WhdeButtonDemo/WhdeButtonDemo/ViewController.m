//
//  ViewController.m
//  WhdeButtonDemo
//
//  Created by whde on 16/4/29.
//  Copyright © 2016年 whde. All rights reserved.
//

#import "ViewController.h"
#import "UIButtonLoad.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButtonLoad *btn = [UIButtonLoad buttonWithType:UIButtonTypeCustom];
    [btn addAction:^(UIButtonLoad *btn) {
        [btn finished];
//        NSLog(@"start");
//        __block int timeout= 2;
//        __block UIButtonLoad *wsendCodeBtn = btn;
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
//        dispatch_source_set_event_handler(timer, ^{
//            if(timeout< 0){
//                dispatch_source_cancel(timer);
//                [wsendCodeBtn finished];
//                NSLog(@"finished");
//            } else {
//                NSLog(@"%d", timeout);
//                timeout--;
//            }
//        });
//        dispatch_resume(timer);
    }];
    [btn setBackgroundImage:[UIImage imageNamed:@"29pt@3x"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 300, 150);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
