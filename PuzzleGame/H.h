//
//  H.h
//  TrackMyTruck
//
//  Created by Lion User on 22/08/2012.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>


#import "Session.h"

#define rmlog(str) NSLog(@"%@",str)

@interface H : NSObject

+(BOOL)validateEmailWithString:(NSString*)email;

+(NSString*) getDeviceID;

+(NSString*) md5:(NSString*)str;

+(NSNumber*) doubleFromString:(NSString*)str;
+(NSNumber*) intFromString:(NSString*)str;

+(BOOL) isNSNull:(id)object;

+(void) alert:(NSString*)title description:(NSString*)description;

+(UIImage*) getImage:(NSString*)filename;
+(void) pushLocalNotificationWithBody:(NSString*)body;

+(NSString*) base64encode:(NSString*)string;
+(NSString*) base64decode:(NSString*)string;

+(UIColor*) colorFromR:(float) r G:(float)g B:(float)b A:(float)a;

+(NSString*) GUID;
+(NSNumber*) ID;

+(BOOL) isIphone5;

@end

@interface NSDictionary(GTDictionary)
-(NSNumber*) intForKey:(NSString*)key;
-(NSNumber*) doubleForKey:(NSString*)key;
-(NSString*) stringForKey:(NSString*)key;
-(NSDate*) dateForKey:(NSString*)key;
@end

@interface UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
@end

@interface NSMutableArray (Shuffling)
- (void)shuffle;
@end
