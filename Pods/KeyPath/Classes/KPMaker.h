//
//  KPMaker.h
//  KeyPath
//
//  Created by lzhu on 7/3/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPMaker : NSObject

- (NSString *) keyPath;

- (NSString *) pathWithSeparator:(NSString*)separator;

@end

