//
//  NSString+BasicShareKit.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BasicShareKit)

+ (BOOL)isNilOrEmpty:(NSString *)string;
+ (BOOL)isNilOrEmptyOrWhitespace:(NSString *)string;
+ (NSString *)nonNullString:(NSString *)string;
+ (NSString *)nonEmptyStringOrNil:(NSString *)string;
+ (NSString *)nonEmptyTrimmedStringOrNil:(NSString *)string;
+ (NSString *)newUUIDString;

- (BOOL)contains:(NSString *)substring;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)trimmedString;
- (NSNumber *)numberWithString;

-(NSMutableArray *)substringByRegular:(NSString *)regular;

@end
