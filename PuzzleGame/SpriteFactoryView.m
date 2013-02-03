//
//  SpriteFactoryView.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "SpriteFactoryView.h"

#define GAME_BORDER 4

#define GAME_WIDTH 300
#define GAME_HEIGHT 382


@interface SpriteFactoryView()

@property (retain, nonatomic) UIImage * puzzle;
@property (retain,nonatomic) NSArray * sprites;

- (Sprite*) findColisionsWithSprite:(Sprite*)sprite;

- (void) shuffleSprites;
- (void) checkEndGameCondition;

@end

@implementation SpriteFactoryView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.soundOn = YES;
    }
    return self;
}


- (void) initSpritesRows:(int)rows columns:(int)columns image:(NSString*)image {
    [self clearSprites];
    
    self.puzzle = nil;
    self.puzzle = [UIImage imageNamed:image];
    
    NSMutableArray * sprites = [NSMutableArray new];
    CGImageRef cgImageRef = [self.puzzle CGImage];
    
    float spriteWidth = CGImageGetWidth(cgImageRef)/(double)columns;
    float spriteHeight = CGImageGetHeight(cgImageRef)/(double)rows;
    for(int row = 0; row < rows; row++) {
        for (int column = 0; column < columns; column++) {
            CGImageRef tempImage =
            CGImageCreateWithImageInRect(cgImageRef, CGRectMake(column * spriteWidth,
                                                                row * spriteHeight,
                                                                spriteWidth,
                                                                spriteHeight));
            
            UIImage * image = [UIImage imageWithCGImage:tempImage];
            CGImageRelease(tempImage);
            Sprite * sprite = [Sprite new];
            
            [sprite setBackgroundImage:image forState:UIControlStateNormal];
            [sprites addObject:sprite];
            
            [self addSubview:sprite];
            
            sprite.x = (double)column * (GAME_WIDTH/(double)columns)+GAME_BORDER;
            sprite.y = (double)row * (GAME_HEIGHT/(double)rows)+GAME_BORDER;
            sprite.width = (GAME_WIDTH/(double)columns);
            sprite.heigt = (GAME_HEIGHT/(double)rows);
            sprite.frame = CGRectMake(sprite.x, sprite.y, sprite.width, sprite.heigt);
            sprite.startFrame = sprite.frame;
            sprite.spriteFactoryView = self;
            sprite.beforeMoveFrame = sprite.frame;
        }
    }
    CGImageRelease(cgImageRef);
    self.sprites = sprites;
    [self shuffleSprites];
    [SoundHelper playSound:CFSTR(SOUND_NEW_GAME)];
}

-(Sprite*) findColisionsWithSprite:(Sprite*)sprite {
    for (Sprite * sp in self.sprites) {
        if([sp isEqual:sprite]) {
            continue;
        }
        
        if(!CGRectContainsPoint(sp.frame, sprite.center)) {
            sp.highlighted = NO;
            continue;
        }

        return sp;
    }

    return nil;
}

- (void) checkColisionsWithSpriteOnMove:(Sprite*)sprite {
    Sprite * sp = [self findColisionsWithSprite:sprite];
    if(sp) {
        sp.highlighted = YES;
    }
    
    for (Sprite * s in self.sprites) {
        if(![sp isEqual:s]) {
            s.highlighted = NO;
        }
    }
}

- (void) checkColisionsWithSpriteOnEndMove:(Sprite*)sprite {
    Sprite * sp = [self findColisionsWithSprite:sprite];
    if(sp) {
        sp.highlighted = NO;
        CGRect position = [sprite moveToPosition:sp.frame animated:NO];
        [sp moveToPosition:position animated:YES];
        [self checkEndGameCondition];
    } else {
        [sprite moveBack];
    }
}

- (void) clearSprites {
    if(self.sprites != nil) {
        for (Sprite * sprite in self.sprites) {
            [sprite removeFromSuperview];
        }
    }
    self.sprites = nil;
}

- (void) shuffleSprites {
    NSMutableArray * positions = [NSMutableArray new];
    
    for (Sprite * sprite in self.sprites) {
        [positions addObject:[NSValue valueWithCGRect:sprite.frame]];
    }
    
    for (int i = 0; i < [self.sprites count]; i++) {
        [positions shuffle];
    }
    
    int index = 0;
    for (Sprite * sprite in self.sprites) {
        [sprite moveToPosition:[[positions objectAtIndex:index] CGRectValue] animated:YES];
        index++;
    }
}

- (void) checkEndGameCondition {
    BOOL gameEnded = YES;
    for (Sprite * sprite in self.sprites) {
        if(![sprite isCorrectPosition]) {
            gameEnded = NO;
        }
    }
    
    if(!gameEnded) {
        [SoundHelper playSound:CFSTR(SOUND_MOVE_SPRITE_WRONG)];
        return;
    }
    
    //TODO: game ended event;
    [SoundHelper playSound:CFSTR(SOUND_GAME_END)];
    rmlog(@"game ended");
    [H alert:@"" description:@"you win!"];
}

@end
