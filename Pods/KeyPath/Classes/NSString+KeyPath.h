//
//  NSString+KeyPath.h
//  KeyPath
//
//  Created by lzhu on 7/3/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPMaker.h"

@interface NSString (KeyPath)

+ (NSString*) keyPathWithMaker:(void(^)(KPMaker *maker))maker;

+ (NSString *) pathWithSeparator:(NSString*)separator maker:(void(^)(KPMaker *maker))maker;

@end

#define KeyPath(kp) \
[NSString keyPathWithMaker:^(KPMaker *maker){ \
    maker.kp; \
}]


