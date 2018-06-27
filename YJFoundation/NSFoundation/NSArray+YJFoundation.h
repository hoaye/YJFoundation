//
//  NSArray+YJFoundation.h
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YJFoundation)

/**
 Secure access to array elements

 @param index index
 @return element
 */
- (id)yj_objectSafeAtIndex:(NSUInteger)index;



@end
