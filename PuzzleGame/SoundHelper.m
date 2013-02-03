//
//  Sound.m
//  PuzzleGame
//
//  Created by Roman on 02.02.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "SoundHelper.h"

@implementation SoundHelper

+ (void) playSound:(CFStringRef)sound {
    
    NSError * setCategoryError;
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef = CFBundleCopyResourceURL(mainBundle, sound, CFSTR("wav"), NULL);
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundId);

    AudioServicesPlaySystemSound(soundId);
    CFRelease(soundFileURLRef);
    AudioServicesPlaySystemSound(soundId);
}

+ (void) playBackground {
 //   NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ambient" ofType:@"mp3"];
 //   NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
 //   AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
 //   player.numberOfLoops = -1; //infinite
 //   [player play];
}

@end
