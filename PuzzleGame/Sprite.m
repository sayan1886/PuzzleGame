//
//  Sprite.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "Sprite.h"

@interface Sprite ()

- (void) initSprite;

@end

@implementation Sprite

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSprite];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSprite];
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        [self initSprite];
    }
    return self;
}

- (void) initSprite {
    self.isBusy = NO;
}


- (CGRect) getRect {
    return  CGRectMake(self.x, self.y, self.width, self.heigt);
}


- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    
    if(![self.spriteFactoryView checkCanMoveSprite:self]) {
        return;
    }
    
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.superview];
    self.center = location;
    [self.spriteFactoryView checkColisionsWithSpriteOnMove:self];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(![self.spriteFactoryView checkCanMoveSprite:self]) {
        return;
    }
    
    [super touchesBegan:touches withEvent:event];
    self.isBusy = YES;
    self.alpha = 0.5f;
    self.layer.zPosition = 1;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(![self.spriteFactoryView checkCanMoveSprite:self]) {
        return;
    }
    
    [super touchesEnded:touches withEvent:event];
    self.isBusy = NO;
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
