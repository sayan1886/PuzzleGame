//
//  Sound.h
//  PuzzleGame
//
//  Created by Roman on 02.02.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundHelper : NSObject

+ (void) playSound:(CFStringRef)sound;
+ (void) playBackground;

@end
