//
//  Sprite.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpriteFactoryView;

@interface Sprite : UIButton

@property (retain,nonatomic) NSMutableArray * sprites;

@property (assign,nonatomic) double width;
@property (assign,nonatomic) double heigt;
@property (assign,nonatomic) double x;
@property (assign,nonatomic) double y;

@property (assign,nonatomic) CGRect startFrame;
@property (assign,nonatomic) CGRect beforeMoveFrame;

@property (retain,nonatomic) SpriteFactoryView * spriteFactoryView;

- (CGRect) getRect;

- (void) moveBack;
- (CGRect) moveToPosition:(CGRect)position animated:(BOOL)animated;

- (BOOL) isCorrectPosition;

@end
