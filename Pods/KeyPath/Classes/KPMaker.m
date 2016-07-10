//
//  KPMaker.m
//  KeyPath
//
//  Created by lzhu on 7/3/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "KPMaker.h"

#import <objc/runtime.h>

@interface KPMakerForwarding : NSObject
@property (weak, nonatomic) KPMaker *keyPathMaker;
@end

@interface KPMaker()
@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) KPMakerForwarding *forwarding;
@end

@implementation KPMaker

- (instancetype) init {
    self = [super init];
    if(self) {
        self.keys = [NSMutableArray array];
        self.forwarding = [[KPMakerForwarding alloc] init];
        self.forwarding.keyPathMaker = self;
    }
    return self;
}

- (NSString *) keyPath {
    return [self.keys componentsJoinedByString:@"."];
}

- (NSString *) pathWithSeparator:(NSString*)separator {
    return [self.keys componentsJoinedByString:separator];
}

- (id) forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorName = NSStringFromSelector(aSelector);
    [self.keys addObject:selectorName];
    return self.forwarding;
}

- (NSMethodSignature*) methodSignatureForSelector:(SEL)aSelector {
    if(![self respondsToSelector:aSelector]) {
        return [NSMethodSignature signatureWithObjCTypes:"@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

@end

@implementation KPMakerForwarding

+ (BOOL) resolveInstanceMethod:(SEL)sel {
    Method method = class_getInstanceMethod([self class], @selector(keyPathMaker));
    IMP imp = method_getImplementation(method);
    const char *type = method_getTypeEncoding(method);
    class_addMethod([self class], sel, imp, type);
    return YES;
}

@end

