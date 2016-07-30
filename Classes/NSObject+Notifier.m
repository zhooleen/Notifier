//
//  NSObject+Notifier.m
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSObject+Notifier.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RTObserver.h"

@interface RTKeyValueObserver : NSObject <RTObserver>

@property (weak, nonatomic) id object;
@property (strong, nonatomic) NSString *keyPath;
@property (assign, nonatomic) NSKeyValueObservingOptions options;
@property (strong, nonatomic) NSString *context;

@property (copy, nonatomic) RTKVOBlock block;

@property (assign, nonatomic, readonly) BOOL observing;

@end


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

- (id<RTObserver>) observerForKeyPath:(NSString*)keyPath withBlock:(RTKVOBlock)block {
    return [self observerForKeyPath:keyPath context:@"redeight" options:(NSKeyValueObservingOptionNew) withBlock:block];
}

- (NSHashTable*) rt_observers {
    return objc_getAssociatedObject(self, "observers");
}

- (void) rt_addObserver:(id<RTObserver>)observer {
    NSHashTable *table = self.rt_observers;
    if(table == nil) {
        table = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, "observers", table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [table addObject:observer];
    [self rt_swizling_dealloc];
}

- (void) rt_removeAllObservers {
    NSHashTable *table = self.rt_observers;
    if(table) {
        NSArray *array = table.allObjects;
        for(RTKeyValueObserver *ob in array) {
            [self removeObserver:ob forKeyPath:ob.keyPath];
            printf("Stop observe keyPath : %s\n", ob.keyPath.UTF8String);
        }
    }
    objc_setAssociatedObject(self, "observers", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) rt_add_dealloc {
    [self rt_removeAllObservers];
}

- (void) rt_replace_dealloc {
    [self rt_removeAllObservers];
    [self rt_replace_dealloc];
}

- (void) rt_swizling_dealloc {
    BOOL swizled = [objc_getAssociatedObject(self.class, "swizled_dealloc") boolValue];
    if(swizled) {
        return;
    }
    SEL sel1 = NSSelectorFromString(@"dealloc");
    SEL sel2 = @selector(rt_add_dealloc);
    SEL sel3 = @selector(rt_replace_dealloc);
    Method m1 = class_getInstanceMethod([self class], sel1);
    Method m2 = class_getInstanceMethod([self class], sel2);
    Method m3 = class_getInstanceMethod([self class], sel3);
    IMP imp1 = method_getImplementation(m1);
    IMP imp2 = method_getImplementation(m2);
    IMP imp3 = method_getImplementation(m3);
    if(!class_addMethod([self class], sel1, imp2, method_getTypeEncoding(m2))) {
        class_replaceMethod([self class], sel1, imp3, method_getTypeEncoding(m1));
        class_replaceMethod([self class], sel3, imp1, method_getTypeEncoding(m3));
    }
    objc_setAssociatedObject(self.class, "swizled_dealloc", @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation RTKeyValueObserver

- (void) startObserve {
    if(_observing) {
        return;
    }
    [self.object rt_addObserver:self];
    [self.object addObserver:self forKeyPath:self.keyPath options:self.options context:(void*)self.context];
    _observing = YES;
    printf("start observe %s\n", [self.keyPath UTF8String]);
}

- (void) stopObserve {
    if(!_observing) {
        return;
    }
    if(self.object) {
        [self.object removeObserver:self forKeyPath:self.keyPath];
    }
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
