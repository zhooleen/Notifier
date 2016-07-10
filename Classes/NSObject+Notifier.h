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

- (id<RTObserver>) observerForKeyPath:(NSString*)keyPath context:(NSString*)context options:(NSKeyValueObservingOptions)options withBlock:(RTKVOBlock)block;

@end
