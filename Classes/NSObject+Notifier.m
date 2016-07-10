//
//  NSObject+Notifier.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSObject+Notifier.h"
#import "RTKeyValueObserver.h"

@implementation NSObject (Notifier)


- (id<RTObserver>) observerForKeyPath:(NSString*)keyPath context:(NSString*)context options:(NSKeyValueObservingOptions)options withBlock:(RTKVOBlock)block {
    RTKeyValueObserver *observer = [[RTKeyValueObserver alloc] init];
    observer.keyPath = keyPath;
    observer.context = context;
    observer.object = self;
    observer.options = options;
    observer.block = block;
    return observer;
}

@end
