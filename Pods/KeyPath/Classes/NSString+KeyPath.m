//
//  NSString+KeyPath.m
//  KeyPath
//
//  Created by lzhu on 7/3/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSString+KeyPath.h"

@implementation NSString (KeyPath)

+ (NSString*) keyPathWithMaker:(void(^)(KPMaker *maker))maker {
    KPMaker *mk = [[KPMaker alloc] init];
    if(maker) {
        maker(mk);
    }
    return mk.keyPath;
}

+ (NSString *) pathWithSeparator:(NSString*)separator maker:(void(^)(KPMaker *maker))maker {
    KPMaker *mk = [[KPMaker alloc] init];
    if(maker) {
        maker(mk);
    }
    return [mk pathWithSeparator:separator];
}

@end
