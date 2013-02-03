//
//  Sprite.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "Sprite.h"

@interface Sprite ()

@end

@implementation Sprite

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (CGRect) getRect {
    return  CGRectMake(self.x, self.y, self.width, self.heigt);
}


- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.superview];
    self.center = location;
    [self.spriteFactoryView checkColisionsWithSpriteOnMove:self];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.alpha = 0.5f;
    self.layer.zPosition = 1;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.alpha = 1;
    self.layer.zPosition = 0;
    [self.spriteFactoryView checkColisionsWithSpriteOnEndMove:self];
}

- (void) moveBack {
    self.frame = self.beforeMoveFrame;
}

-(void) dealloc {
    self.spriteFactoryView = nil;
}

- (CGRect) moveToPosition:(CGRect)position animated:(BOOL)animated {
    CGRect oldPosition = self.beforeMoveFrame;
    if(animated) {
        //TODO: movment animation
        self.frame = position;
        self.beforeMoveFrame = position;
    } else {
        self.frame = position;
        self.beforeMoveFrame = position;
    }

    return oldPosition;
}

- (BOOL) isCorrectPosition {
    return CGRectContainsPoint(self.startFrame, self.center);
}

@end
