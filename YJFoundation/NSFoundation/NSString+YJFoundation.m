//
//  NSString+YJFoundation.m
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "NSString+YJFoundation.h"

@implementation NSString (YJFoundation)

- (NSString *)yj_URLEncoding{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)yj_URLDecoding{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)yj_removeBlank{
    if (self == nil || [self isEqual:[NSNull null]]) {
        return nil;
    }
    return [self stringByReplacingOccurrencesOfString:@"\\s+" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

- (NSString *)yj_trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)yj_isEmpty{
    return [self length] > 0 ? NO : YES;
}

+ (BOOL)yj_isNullOrEmpty:(NSString *)string{
    if (string != nil && ![string isEqual:[NSNull null]]) {
        return [string yj_isEmpty];
    }
    return YES;
}

+ (NSString *)yj_queryStringFromDictionary:(NSDictionary *)dict addingPercentEscapes:(BOOL)add{
    
    NSMutableArray *pairs = [NSMutableArray array];
    for ( NSString *key in [dict keyEnumerator] ){
        
        id value = [dict valueForKey:key];
        if ([value isKindOfClass:[NSNumber class]]){
            value = [value stringValue];
        }else if ([value isKindOfClass:[NSString class]]){
        }else{
            continue;
        }
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@",
                          add?[key yj_URLEncoding]:key,
                          add?[value yj_URLEncoding]:value]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSDictionary *)yj_queryDictionaryUsingEncoding:(NSStringEncoding)encoding queryString:(BOOL)queryString{
    
    NSString *handleString = nil;
    if (queryString) {
        handleString = self;
    }else{
        handleString = [[self componentsSeparatedByString:@"?"] lastObject];
    }
    
    if (handleString == nil || [handleString isEqualToString:@""]) { return nil; }
    
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    NSScanner *scanner = [[NSScanner alloc] initWithString:handleString];
    while (![scanner isAtEnd]) {
        NSString *pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [[[kvPair objectAtIndex:0]
                              stringByReplacingPercentEscapesUsingEncoding:encoding] yj_removeBlank];
            NSString* value = [[[kvPair objectAtIndex:1]
                                stringByReplacingPercentEscapesUsingEncoding:encoding] yj_removeBlank];
            [pairs setObject:value forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString *)yj_urlByAppendingDictionary:(NSDictionary *)params addingPercentEscapes:(BOOL)add{
    
    NSString *handleString = [self yj_URLEncoding];
    NSURL *parsedURL = [NSURL URLWithString:handleString];
    NSString *queryPrefix = parsedURL.query?@"&":@"?";
    NSString *query = [NSString yj_queryStringFromDictionary:params addingPercentEscapes:add];
    return [NSString stringWithFormat:@"%@%@%@", handleString, queryPrefix, query];
}

- (BOOL)yj_isInValues:(NSArray *)array caseInsens:(BOOL)caseInsens{
    
    NSStringCompareOptions option = caseInsens?NSCaseInsensitiveSearch:0;
    for (NSObject * obj in array ){
        if (NO == [obj isKindOfClass:[NSString class]])
            continue;
        if ([(NSString *)obj compare:self options:option] == NSOrderedSame)
            return YES;
    }
    return NO;
}

- (NSString *)yj_formatJSON{
    
    int indentLevel     = 0;
    BOOL inString       = NO;
    char currentChar    = '\0';
    char *tab = "    ";
    
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [self UTF8String];
    NSMutableData *buf = [NSMutableData dataWithCapacity:(NSUInteger)(len * 1.1f)];
    
    for (int i = 0; i < len; i++){
        currentChar = utf8[i];
        switch (currentChar) {
            case '{':
            case '[':
                if (!inString) {
                    [buf appendBytes:&currentChar length:1];
                    [buf appendBytes:"\n" length:1];
                    for (int j = 0; j < indentLevel+1; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                    indentLevel += 1;
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case '}':
            case ']':
                if (!inString) {
                    indentLevel -= 1;
                    [buf appendBytes:"\n" length:1];
                    for (int j = 0; j < indentLevel; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                    [buf appendBytes:&currentChar length:1];
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ',':
                if (!inString) {
                    [buf appendBytes:",\n" length:2];
                    for (int j = 0; j < indentLevel; j++) {
                        [buf appendBytes:tab length:strlen(tab)];
                    }
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ':':
                if (!inString) {
                    [buf appendBytes:":" length:1];
                } else {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case ' ':
            case '\n':
            case '\t':
            case '\r':
                if (inString) {
                    [buf appendBytes:&currentChar length:1];
                }
                break;
            case '"':
                if (i > 0 && utf8[i-1] != '\\'){
                    inString = !inString;
                }
                [buf appendBytes:&currentChar length:1];
                break;
            default:
                [buf appendBytes:&currentChar length:1];
                break;
        }
    }
    return [[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding];
}

+ (NSString *)yj_getUUIDString{
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

- (NSString *)yj_positiveFormat{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
}





@end
