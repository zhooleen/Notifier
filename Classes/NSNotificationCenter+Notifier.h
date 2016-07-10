//
//  NSNotificationCenter+Notifier.h
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTObserver.h"

@interface NSNotificationCenter (Notifier)

- (id<RTObserver>) observerForName:(NSString*)name sender:(id)sender withTarget:(id)target action:(SEL)action;

- (id<RTObserver>) observerForName:(NSString*)name sender:(id)sender withBlock:(RTNotificationBlock)block;

@end
