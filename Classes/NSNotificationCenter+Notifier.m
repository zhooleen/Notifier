//
//  NSNotificationCenter+Notifier.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSNotificationCenter+Notifier.h"

#import "RTNotificationObserver.h"


@implementation NSNotificationCenter (Notifier)

- (id<RTObserver>) observerForName:(NSString*)name sender:(id)sender withTarget:(id)target action:(SEL)action {
    RTNotificationObserver *observer = [[RTNotificationObserver alloc] init];
    observer.name = name;
    observer.sender = sender;
    observer.target = target;
    observer.action = action;
    return observer;
}

- (id<RTObserver>) observerForName:(NSString*)name sender:(id)sender withBlock:(RTNotificationBlock)block {
    RTNotificationObserver *observer = [[RTNotificationObserver alloc] init];
    observer.name = name;
    observer.sender = sender;
    observer.block = block;
    return observer;
}

@end
