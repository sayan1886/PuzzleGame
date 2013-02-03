//
//  BaseController.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE_SUF @"_iPhone"
#define IPAD_SUF @"_iPad"

@class NavigationController;

@interface BaseController : UIViewController

@property (retain,nonatomic) NavigationController * navigator;
@property (retain,nonatomic) NSString * imagename;

- (id) initWithUniversalNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
