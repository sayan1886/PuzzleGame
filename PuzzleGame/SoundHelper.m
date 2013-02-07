//
//  Sound.m
//  PuzzleGame
//
//  Created by Roman on 02.02.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "SoundHelper.h"

@interface SoundHelper()

@end

@implementation SoundHelper

static AVAudioPlayer * backgroundPlayer;
static AVAudioPlayer * soundPlayer;

static bool _mute = NO;

+ (void) playSound:(NSString*)sound {
    if(!_mute) {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ding" ofType:@"wav"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        soundPlayer.numberOfLoops = 0; //infinite
        soundPlayer.volume = 1.0f;
        [soundPlayer play];
    }
}

+ (void) playBackground {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ambient" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    backgroundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    backgroundPlayer.numberOfLoops = -1; //infinite
    if(!_mute) {
        backgroundPlayer.volume = 0.3f;
    } else {
        backgroundPlayer.volume = 0.0f;
    }
    [backgroundPlayer play];
}

+ (void) muteSound:(BOOL)mute {
    _mute = mute;
    if(_mute) {
        backgroundPlayer.volume = 0.0f;
        [soundPlayer stop];
    } else {
        backgroundPlayer.volume = 0.3f;
    }
}

@end
