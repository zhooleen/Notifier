//
//  RTNotificationObserver.h
//  Notifier
//
//  Created by lzhu on 7/10/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTObserver.h"


@interface RTNotificationObserver : NSObject <RTObserver>

@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) id sender;

@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@property (copy, nonatomic) RTNotificationBlock block;

@property (assign, nonatomic, readonly) BOOL observing;

@end
