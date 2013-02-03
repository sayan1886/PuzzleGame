//
//  MenuController.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "MenuController.h"

@interface MenuController ()

- (void) initMenu;

- (void) selectedGameFree:(GameIcon*)sender;
- (void) selectedGamePaid:(GameIcon*)sender;

@end

@implementation MenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initMenu {
    
    int iconWidth = 75;
    int iconHeight = 75;
    
    int intervalX = (320-3*iconWidth)/4;
    int intervalY = 10;
    
    for (int i = 0; i < 3; i++) {
        GameIcon * gameIcon = [GameIcon new];
        gameIcon.imagename = [NSString stringWithFormat:@"cat_free_0%d.png",i+1];
        [gameIcon setImage:[UIImage imageNamed:gameIcon.imagename] forState:UIControlStateNormal];
        gameIcon.frame = CGRectMake((intervalX+iconWidth)*i+intervalX, intervalY, iconWidth, iconHeight);
        gameIcon.backgroundColor = [UIColor greenColor];
        [gameIcon addTarget:self action:@selector(selectedGameFree:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gameIcon];
    }
    
    
    int row = 0;
    int column = 0;
    for (int i = 3; i < 15; i++) {
        
        if(column == 3) {
            column = 0;
            row++;
        }
        
        GameIcon * gameIcon = [GameIcon new];
        gameIcon.frame = CGRectMake((intervalX+iconWidth)*column+intervalX, (intervalY+iconWidth)*row+intervalY, iconWidth, iconHeight);
        gameIcon.backgroundColor = [UIColor redColor];
        [gameIcon addTarget:self action:@selector(selectedGamePaid:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewIconsList addSubview:gameIcon];
        column ++;
    }
    
    [self.viewIconsList setScrollEnabled:YES];
    [self.viewIconsList setContentSize:CGSizeMake(320,row*iconHeight+row*intervalY+iconHeight+intervalY*2)];
    [self.viewIconsList setContentOffset:CGPointMake(0, 0)];
}

- (void) selectedGameFree:(GameIcon*)sender {
    [self.navigator showGameImage:sender.imagename];
}

- (void) selectedGamePaid:(GameIcon*)sender {
    rmlog(@"no money no honey");
}

- (void)viewDidUnload {
    [self setViewIconsList:nil];
    [super viewDidUnload];
}


@end
