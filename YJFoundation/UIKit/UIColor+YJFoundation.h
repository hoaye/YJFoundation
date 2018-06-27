//
//  UIColor+YJFoundation.h
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色创建
#undef  YJRGBCOLOR
#define YJRGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  YJRGBACOLOR
#define YJRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef  YJHEX_RGB
#define YJHEX_RGB(v)        [UIColor colorWithRGBHex:v]

@interface UIColor (YJFoundation)

/**
 Get Color form RGBHex

 @param hex hex
 @return UIColor
 */
+ (UIColor *)yj_colorWithRGBHex:(UInt32)hex;

/**
 Get Color form hexString

 @param hexString @"FF1493" or @"#FF1493"
 @return UIColor
 */
+ (UIColor *)yj_colorWithHexString:(NSString *)hexString;

@end
