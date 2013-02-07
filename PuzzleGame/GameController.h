//
//  GameController.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"
#import "SpriteFactoryView.h"

#define GAME_MODE_6 6
#define GAME_MODE_9 9
#define GAME_MODE_12 12

@interface GameController : BaseController

@property (assign,nonatomic) int currentMode;

@property (retain, nonatomic) IBOutlet SpriteFactoryView *viewPuzzle;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnSoundMute;

- (IBAction)selectedBack:(UIButton *)sender;

- (void) init6Sprites;
- (void) init9Sprites;
- (void) init12Sprites;

- (IBAction)tapSoundMute:(UIButton *)sender;

@end
