//
//  H.m
//  TrackMyTruck
//
//  Created by Roman on 22/08/2012.
//  Copyright (c) 2012 TMT. All rights reserved.
//

#import "H.h"

@implementation H

+(BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(NSString*) getDeviceID {
    return [UIDevice currentDevice].uniqueIdentifier;//depricated
}

+(NSNumber*) doubleFromString:(NSString*)str {
    return [NSNumber numberWithDouble:[str doubleValue]];
}

+(NSNumber*) intFromString:(NSString*)str {
    return [NSNumber numberWithInt:[str doubleValue]];
}

+(NSString*) md5:(NSString*)str {
/*
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
 */
    return  nil;
}

+(BOOL) isNSNull:(id)object {
    return [object isKindOfClass:[NSNull class]];
}

//#########################################################################

+(BOOL) checkDateInterval:(NSDate*)date interval:(double)value {
    if(date == nil) {
        return YES;
    }
    double interval = (double)[[NSDate date] timeIntervalSinceDate:date];
    if(interval >= value) {
        return YES;
    }
    return NO;
}


+(void) alert:(NSString*)title description:(NSString*)description {
    UIAlertView * alert =
        [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



+(UIImage*) getImage:(NSString*)filename {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * docs = [paths objectAtIndex:0];
    NSString * path =  [docs stringByAppendingFormat:@"/%@",filename];
    //NSLog(@"image path: %@",path);
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    return image;
}



+(void) pushLocalNotificationWithBody:(NSString*)body {
    UIApplication * app = [UIApplication sharedApplication];
    
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    //alarm.fireDate = theDate;
    alarm.timeZone = [NSTimeZone defaultTimeZone];
    //alarm.repeatInterval = 5;
    alarm.soundName = @"alarmsound.caf";
    alarm.alertBody = body;
    alarm.alertAction = @"Track My Truck";
    [app scheduleLocalNotification:alarm];
}

+(NSString*)timeIntervalToString:(NSTimeInterval)interval {
    long work = (long)interval; // convert to long, NSTimeInterval is *some* numeric type
    long seconds = work % 60;   // remainder is seconds
    work /= 60;                 // total number of mins
    long minutes = work % 60;   // remainder is minutes
    long hours = work / 60;      // number of hours
    
    // now format and return - %ld is long decimal, %02ld is zero-padded two digit long decimal
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
}

+(NSString*) base64encode:(NSString*)string {
    //return [string base64EncodedString];
    return nil;
}

+(NSString*) base64decode:(NSString*)string {
    //return [string base64DecodedString];
    return nil;
}

+(UIColor*) colorFromR:(float)r G:(float)g B:(float)b A:(float)a {
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a];
}

+(NSString*) GUID {
    return  [self md5:[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]]];
}

+(NSNumber*) ID {
    NSString * key = @"entity_id";
    NSNumber * guid = [Session getNumberForKey:key];
    if(guid == nil) {
        guid = [NSNumber numberWithInt:-1];
    }
    
    int val = [guid intValue];
    [Session setNumber:[NSNumber numberWithInt:--val] forKey:key];
    return guid;
}

+(BOOL) isIphone5 {
    if([UIScreen mainScreen].bounds.size.height == 568.0) {
        return  YES;
    } else {
        return  NO;
    }
}

@end

//#########################################################################

@implementation NSDictionary ( GTDictionary )
- (NSNumber*) intForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if([H isNSNull:obj]) {
        return nil;
    }
    return [NSNumber numberWithInt:[(NSString*)obj intValue]];
}
- (NSNumber*) doubleForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if([H isNSNull:obj]) {
        return nil;
    }
    return [NSNumber numberWithDouble:[(NSString*)obj doubleValue]];
}
- (NSString*) stringForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if([H isNSNull:obj]) {
        return nil;
    }
    return (NSString*)obj;
}
- (NSDate*) dateForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if([H isNSNull:obj]) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970: [[self doubleForKey:key] doubleValue]];
}
@end


CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
    
}
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    //   CGSize imageSize = sourceImage.size;
    //   CGFloat width = imageSize.width;
    //   CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    //   CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}
- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
@end

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end