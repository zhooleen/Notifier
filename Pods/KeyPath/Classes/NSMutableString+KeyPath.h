//
//  NSMutableString+KeyPath.h
//  KeyPath
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPMaker.h"

typedef NSMutableString* (^KPAppendBlock) (id mkr);

@interface NSMutableString (KeyPath)

- (KPAppendBlock) appendKeyPath;

@end

#define KPMakerInvoke(selector) [(id)([[KPMaker alloc] init]) selector]

#define KP [NSMutableString string]

#define KPAppend(selector) appendKeyPath(KPMakerInvoke(selector))

#define _ KPAppend
