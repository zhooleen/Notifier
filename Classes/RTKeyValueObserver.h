//
//  RTKeyValueObserver.h
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTObserver.h"

@interface RTKeyValueObserver : NSObject <RTObserver>

@property (strong, nonatomic) id object;
@property (strong, nonatomic) NSString *keyPath;
@property (assign, nonatomic) NSKeyValueObservingOptions options;
@property (strong, nonatomic) NSString *context;

@property (copy, nonatomic) RTKVOBlock block;

@property (assign, nonatomic, readonly) BOOL observing;


@end
