//
//  ViewController2.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "ViewController2.h"

#import "Notifier.h"

@interface Model : NSObject
@property (strong, nonatomic) NSString *title;
@end @implementation Model

@end

@interface ViewController2 ()

@property (strong, nonatomic) id<RTObserver> observer;

@end

@implementation ViewController2

- (void)viewDidLoad {
    Model *m = [[Model alloc] init];
    self.observer = [m observerForKeyPath:@"title" withBlock:^(NSDictionary *change) {
        printf("receive kvo of title\n");
    }];
    [self.observer startObserve];
    m.title = @"haha";
}

- (void) viewWillAppear:(BOOL)animated {

}

- (void) viewDidAppear:(BOOL)animated {

}

- (void) viewWillDisappear:(BOOL)animated {
    //Test 1
//    [self.observer stopObserve];
    
    //Test 2
    //Nothing to do
}

@end
