//
//  NSArray+SHYUtil.m
//  Market
//
//  Created by Mac on 15/11/26.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "NSArray+SHYUtil.h"

@implementation NSArray (SHYUtil)
- (id)objectAtIndexCheck:(NSUInteger)index {
    if (index >= [self count])
    {
        return nil;
    }
    id value = [self objectAtIndex:index];
    if (value == [NSNull null])
    {
        return nil;
    }
    return value;
}

@end
