//
//  NSString+YJFoundation.h
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJFoundation)

/**
 UTF8Encoding URL

 @return AddingPercentEscapes
 */
- (NSString *)yj_URLEncoding;

/**
 UTF8Decoding

 @return ReplacingPercentEscapes
 */
- (NSString *)yj_URLDecoding;

/**
 removeBlank

 @return removed
 */
- (NSString *)yj_removeBlank;

/**
 trim

 @return trim result
 */
- (NSString *)yj_trim;

/**
 String isEmpty

 @return String isEmpty BOOL
 */
- (BOOL)yj_isEmpty;

/**
 String is Null or Empty

 @param string pending string
 @return String is Null or Empty
 */
+ (BOOL)yj_isNullOrEmpty:(NSString *)string;

/**
 Dictionary convert to queryString

 @param dict query Dictionary
 @param add addingPercentEscapes
 @return queryString
 */
+ (NSString *)yj_queryStringFromDictionary:(NSDictionary *)dict addingPercentEscapes:(BOOL)add;

/**
 Get query to Dictionary

 @param encoding encoding
 @param queryString is queryString or not
 @return query Dictionary
 */
- (NSDictionary *)yj_queryDictionaryUsingEncoding:(NSStringEncoding)encoding queryString:(BOOL)queryString;

/**
 url Appending query

 @param params query Dictionary
 @param add addingPercentEscapes
 @return new url
 */
- (NSString *)yj_urlByAppendingDictionary:(NSDictionary *)params addingPercentEscapes:(BOOL)add;

/**
 value is ValueOf array

 @param array arraySet
 @param caseInsens caseInsens BOOL
 @return value is Value of array
 */
- (BOOL)yj_isInValues:(NSArray *)array caseInsens:(BOOL)caseInsens;

/**
 Format String to JSON

 @return format JSON
 */
- (NSString *)yj_formatJSON;

/**
 Get UUID

 @return UUID String
 */
+ (NSString *)yj_getUUIDString;

/**
 @"1001" Convert to @"1,001.00"

 @return positiveFormat
 */
- (NSString *)yj_positiveFormat;


@end
