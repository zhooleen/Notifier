//
//  NSObject+Notifier.h
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTObserver.h"

@interface NSObject (Notifier)

/**
 * 1. Hold the return value by strong reference
 * 2. Invoke [observer startObserve] to start observing, then invoke [observer stopObserve] to stop observing.
 * 3. When ARC invokes [observer dealloc], stop observing automatically.
 * 4. When the observed object, that is self, deallocated, stop observing automatically too.
 */

- (id<RTObserver>) observerForKeyPath:(NSString*)keyPath context:(NSString*)context options:(NSKeyValueObservingOptions)options withBlock:(RTKVOBlock)block;

- (id<RTObserver>) observerForKeyPath:(NSString*)keyPath withBlock:(RTKVOBlock)block;

@end

