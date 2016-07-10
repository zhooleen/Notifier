//
//  RTNotificationObserver.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTNotificationObserver.h"

@implementation RTNotificationObserver

- (instancetype) init {
    if(self = [super init]) {
        _observing = NO;
        _name = nil;
        _target = nil;
        _action = nil;
        _block = nil;
    }
    return self;
}

- (void) startObserve {
    if(_observing) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:self.name object:self.sender];
    _observing = YES;
    printf("start observe %s\n", [self.name UTF8String]);
}

- (void) stopObserve {
    if(!_observing) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.name object:self.sender];
    _observing = NO;
    printf("stop observe %s\n", [self.name UTF8String]);
}


- (void) handleNotification:(NSNotification*)notification {
    if(self.block) {
        self.block(notification);
    } else if(self.target && self.action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [self.target performSelector:self.action withObject:notification];
#pragma clang diagnostic pop
    } else {
        [self stopObserve];
    }
}

- (void) dealloc {
    [self stopObserve];
}

@end
