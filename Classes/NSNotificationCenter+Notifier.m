//
//  NSNotificationCenter+Notifier.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSNotificationCenter+Notifier.h"
#import "RTObserver.h"


@interface RTNotificationObserver : NSObject <RTObserver>

@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) id sender;

@property (copy, nonatomic) RTNotificationBlock block;

@property (assign, nonatomic, readonly) BOOL observing;

@end

@implementation NSNotificationCenter (Notifier)


- (id<RTObserver>) observerForName:(NSString*)name sender:(id)sender withBlock:(RTNotificationBlock)block {
    RTNotificationObserver *observer = [[RTNotificationObserver alloc] init];
    observer.name = name;
    observer.sender = sender;
    observer.block = block;
    return observer;
}

- (id<RTObserver>) observerForName:(NSString*)name withBlock:(RTNotificationBlock)block {
    return [self observerForName:name sender:nil withBlock:block];
}

@end


@implementation RTNotificationObserver

- (instancetype) init {
    if(self = [super init]) {
        _observing = NO;
        _name = nil;
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
    if(notification.object != self.sender) {
        return;
    }
    if(self.block) {
        self.block(notification);
    } else {
        [self stopObserve];
    }
}

- (void) dealloc {
    [self stopObserve];
}

@end
