//
//  NSString+BasicShareKit.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "NSString+BasicShareKit.h"

@implementation NSString (BasicShareKit)

+ (BOOL)isNilOrEmpty:(NSString *)string
{
	return (!string || [string length] <= 0);
}

+ (BOOL)isNilOrEmptyOrWhitespace:(NSString *)string
{
	return (!string || [[string trimmedString] length] <= 0);
}

+ (NSString *)nonNullString:(NSString *)string
{
	return (string ? string : [NSString string]);
}

+ (NSString *)nonEmptyStringOrNil:(NSString *)string
{
	if ([self isNilOrEmpty:string])
    {
		return nil;
    }
	return string;
}

+ (NSString *)nonEmptyTrimmedStringOrNil:(NSString *)string
{
	if ([self isNilOrEmptyOrWhitespace:string])
    {
        return nil;
    }
	return [string trimmedString];
}

+ (NSString *)newUUIDString
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	NSString *string = ( NSString *)CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return string;
}

- (BOOL)contains:(NSString *)substring
{
	return ([self rangeOfString:substring].location != NSNotFound);
}

- (NSString *)URLEncodedString
{
    NSString *encoded = (NSString *)
	CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
											( CFStringRef)self,
											NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
	return [encoded autorelease];
}

- (NSString *)URLDecodedString
{
	return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trimmedString
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSNumber *)numberWithString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [formatter numberFromString:self];
    [formatter release];
    return number;
}

- (NSMutableArray *)substringByRegular:(NSString *)regular
{
    NSRange r = [self rangeOfString:regular options:NSRegularExpressionSearch];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0)
    {
        while (r.length != NSNotFound &&r.length != 0)
        {
            NSString* substr = [self substringWithRange:r];
            [arr addObject:substr];
            NSRange startr = NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            r = [self rangeOfString:regular options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}

@end
