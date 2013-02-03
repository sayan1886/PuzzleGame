//
//  Session.m
//  Apply
//
//  Created by Roman on 10.12.12.
//  Copyright (c) 2012 Apply Inrentive. All rights reserved.
//

#import "Session.h"

@implementation Session

+(void)setString:(NSString*)str forKey:(NSString*)key {
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings setObject : str forKey : key];
    [settings synchronize];
}

+(void)setObject:(NSObject*)object forKey:(NSString*)key {
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings setObject : object forKey : key];
    [settings synchronize];
}


+(void)setBool:(BOOL)value forKey:(NSString*)key {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setBool : value forKey : key];
    [settings synchronize];
}

+(void)setInt:(int)value forKey:(NSString*)key {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger : value forKey : key];
    [settings synchronize];
}

+(void)setDouble:(double)value forKey:(NSString*)key {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setDouble:value forKey : key];
    [settings synchronize];
}

+(void)setDate:(NSDate*)date forKey:(NSString*)key {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:date forKey:key];
    [settings synchronize];
}

+(void)setNumber:(NSNumber*)number forKey:(NSString*)key {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:number forKey:key];
    [settings synchronize];
}

//******************************************************


+(NSString*)getStringForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+(NSObject*)getObjectForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(BOOL)getBoolForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+(int)getIntForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+(double)getDoubleForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}


+(NSDate*)getDateForKey:(NSString*)key {
    return (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(NSNumber*)getNumberForKey:(NSString*)key {
    return (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
