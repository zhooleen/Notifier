//
//  RTObserver.h
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RTNotificationBlock)(NSNotification* notification);

typedef void (^RTKVOBlock)(NSDictionary *change);

@protocol RTObserver <NSObject>

- (void) startObserve;

- (void) stopObserve;

@property (assign, nonatomic, readonly) BOOL observing;

@end
