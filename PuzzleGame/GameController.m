//
//  GameController.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "GameController.h"

@interface GameController ()

- (void) init6Sprites;
- (void) init9Sprites;
- (void) init12Sprites;

@end

@implementation GameController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if([Session getBoolForKey:SESSION_SOUND_MUTE]) {
        [self.btnSoundMute setImage:[UIImage imageNamed:@"header_soundOFF.png"] forState:UIControlStateNormal];
    } else {
        [self.btnSoundMute setImage:[UIImage imageNamed:@"header_sound_ON.png"] forState:UIControlStateNormal];
    }
    
    self.currentMode = GAME_MODE_6;
}

-(void) viewWillAppear:(BOOL)animated {
    [self init6Sprites];
    [super viewWillAppear:animated];
}

- (IBAction)selectedBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectedGameMode:(UIButton *)sender {
    switch (sender.tag) {
        case GAME_MODE_6:
            self.currentMode = GAME_MODE_6;
            break;
        case GAME_MODE_9:
            self.currentMode = GAME_MODE_9;
            break;
        case GAME_MODE_12:
            self.currentMode = GAME_MODE_12;
            break;
    }
    
    switch (self.currentMode) {
        case GAME_MODE_6:
            [self init6Sprites];
            break;
        case GAME_MODE_9:
            [self init9Sprites];
            break;
        case GAME_MODE_12:
            [self init12Sprites];
            break;
    }
}

- (void) init6Sprites {
    [self.viewPuzzle initSpritesRows:3 columns:2 image:self.imagename];
}

- (void) init9Sprites {
    [self.viewPuzzle initSpritesRows:3 columns:3 image:self.imagename];
}

- (void) init12Sprites {
    [self.viewPuzzle initSpritesRows:4 columns:3 image:self.imagename];
}

- (IBAction)tapSoundMute:(UIButton *)sender {
    if([Session getBoolForKey:SESSION_SOUND_MUTE]) {
        [self.btnSoundMute setImage:[UIImage imageNamed:@"header_sound_ON.png"] forState:UIControlStateNormal];
        [Session setBool:NO forKey:SESSION_SOUND_MUTE];
        [SoundHelper muteSound:NO];
    } else {
        [self.btnSoundMute setImage:[UIImage imageNamed:@"header_soundOFF.png"] forState:UIControlStateNormal];
        [Session setBool:YES forKey:SESSION_SOUND_MUTE];
        [SoundHelper muteSound:YES];
    }
}

- (void)viewDidUnload {
    [self setBtnSoundMute:nil];
    [super viewDidUnload];
}
@end
