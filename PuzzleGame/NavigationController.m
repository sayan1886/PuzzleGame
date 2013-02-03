//
//  NavigationController.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@property (retain,nonatomic) MenuController * menuView;
@property (retain,nonatomic) GameController * gameView;

@end

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationBarHidden = YES;
    [SoundHelper playBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    self.menuView = nil;
    self.gameView = nil;
}

- (void) showMenu {
    
    if(self.gameView != nil) {
        [self.gameView removeFromParentViewController];
        self.gameView = nil;
    }
    
    if(self.menuView != nil) {
        [self.menuView removeFromParentViewController];
        self.menuView = nil;
    }
    self.menuView = [[MenuController alloc] initWithUniversalNibName:@"MenuView" bundle:nil];
    [self pushViewController:self.menuView animated:YES];
}

- (void) showGameImage:(NSString*)image {
    if(self.gameView != nil) {
        [self.gameView removeFromParentViewController];
        self.gameView = nil;
    }
    self.gameView = [[GameController alloc] initWithUniversalNibName:@"GameView" bundle:nil];
    self.gameView.imagename = image;
    [self pushViewController:self.gameView animated:YES];
}

@end
