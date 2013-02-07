//
//  SpriteFactoryView.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Sprite.h"

@interface SpriteFactoryView : UIView

@property (assign,nonatomic) BOOL soundOn;

- (void) initSpritesRows:(int)rows columns:(int)columns image:(NSString*)image;

- (void) checkColisionsWithSpriteOnMove:(Sprite*)sprite;
- (void) checkColisionsWithSpriteOnEndMove:(Sprite*)sprite;

- (BOOL) checkCanMoveSprite:(Sprite*)sprite;

@end
