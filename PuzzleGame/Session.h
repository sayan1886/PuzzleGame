//
//  Session.h
//  Apply
//
//  Created by Roman on 10.12.12.
//  Copyright (c) 2012 Apply Inrentive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+(void)setString:(NSString*)str forKey:(NSString*)key;
+(void)setObject:(NSObject*)object forKey:(NSString*)key;
+(void)setBool:(BOOL)value forKey:(NSString*)key;
+(void)setInt:(int)value forKey:(NSString*)key;
+(void)setDouble:(double)value forKey:(NSString*)key;
+(void)setDate:(NSDate*)date forKey:(NSString*)key;
+(void)setNumber:(NSNumber*)number forKey:(NSString*)key;

+(NSString*)getStringForKey:(NSString*)key;
+(NSObject*)getObjectForKey:(NSString*)key;
+(BOOL)getBoolForKey:(NSString*)key;
+(int)getIntForKey:(NSString*)key;
+(double)getDoubleForKey:(NSString*)key;
+(NSDate*)getDateForKey:(NSString*)key;
+(NSNumber*)getNumberForKey:(NSString*)key;

@end
