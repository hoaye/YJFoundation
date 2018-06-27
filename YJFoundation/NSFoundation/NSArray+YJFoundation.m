//
//  NSArray+YJFoundation.m
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "NSArray+YJFoundation.h"

@implementation NSArray (YJFoundation)

- (id)yj_objectSafeAtIndex:(NSUInteger)index{
    if (self.count > index){
        return [self objectAtIndex:index];
    }
    return nil;
}


@end
