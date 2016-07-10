//
//  NSMutableString+KeyPath.m
//  KeyPath
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "NSMutableString+KeyPath.h"

@implementation NSMutableString (KeyPath)


- (KPAppendBlock) appendKeyPath {
    return ^NSMutableString*(id mkr) {
        KPMaker *maker = (KPMaker*)mkr;
        if(self.length) [self appendString:@"."];
        [self appendString:[maker pathWithSeparator:@"."]];
        return self;
    };
}

@end
