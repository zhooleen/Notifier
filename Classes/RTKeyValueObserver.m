//
//  RTKeyValueObserver.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTKeyValueObserver.h"
#import "NSObject+Notifier.h"

@implementation RTKeyValueObserver

- (void) startObserve {
    if(_observing) {
        return;
    }
    [self.object addObserver:self forKeyPath:self.keyPath options:self.options context:(void*)self.context];
    _observing = YES;
    printf("start observe %s\n", [self.keyPath UTF8String]);
}

- (void) stopObserve {
    if(!_observing) {
        return;
    }
    [self.object removeObserver:self forKeyPath:self.keyPath context:(void*)self.context];
    _observing = NO;
    printf("stop observe %s\n", [self.keyPath UTF8String]);
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    if(self.block) {
        self.block(change);
    } else {
        [self stopObserve];
    }
}

- (void) dealloc {
    [self stopObserve];
}

@end
