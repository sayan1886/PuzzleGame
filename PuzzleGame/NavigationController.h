//
//  NavigationController.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuController.h"
#import "GameController.h"

#import "SoundHelper.h"

@interface NavigationController : UINavigationController

- (void) showMenu;
- (void) showGameImage:(NSString*)image;

@end
