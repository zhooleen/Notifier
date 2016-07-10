//
//  ViewController2.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "ViewController2.h"

#import "Notifier.h"

#import <KeyPath/NSString+KeyPath.h>

@interface KPMaker (TEST)

- (KPMaker*) com;
- (KPMaker*) redeight;
- (KPMaker*) notifier;
- (KPMaker*) test;

- (KPMaker*) title;

@end

@interface Model : NSObject
@property (strong, nonatomic) NSString *title;
@end @implementation Model @end

@interface ViewController2 ()

@property (strong, nonatomic) Model *model;
@property (strong, nonatomic) id<RTObserver> observer;
@property (strong, nonatomic) id<RTObserver> titleObserver;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *name = KeyPath(com.redeight.notifier.test);
    _observer = [[NSNotificationCenter defaultCenter] observerForName:name sender:nil withBlock:^(NSNotification *notification) {
        printf("Response to name : %s\n", [name UTF8String]);
    }];
    [_observer startObserve];
    
    self.model = [[Model alloc] init];
    self.titleObserver = [self.model observerForKeyPath:KeyPath(title) context:nil options:0 withBlock:^(NSDictionary *change) {
        printf("response to KeyPath\n");
        NSLog(@"%@", change);
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.observer startObserve];
    [self.titleObserver startObserve];
}

- (void) viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:KeyPath(com.redeight.notifier.test) object:nil];
    self.model.title = @"HAHAH";
}

- (void) viewWillDisappear:(BOOL)animated {
    //Test 1
//    [self.observer stopObserve];
    
    //Test 2
    //Nothing to do
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
