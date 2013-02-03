//
//  BaseController.m
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController


- (id) initWithUniversalNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(nibNameOrNil == nil) {
        return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    
    NSString * viewName = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([H isIphone5]) {
            viewName = [NSString stringWithFormat:@"%@%@5x",nibNameOrNil,IPHONE_SUF];
        } else {
            viewName = [NSString stringWithFormat:@"%@%@",nibNameOrNil,IPHONE_SUF];
        }
    } else {
        viewName = [NSString stringWithFormat:@"%@%@",nibNameOrNil,IPAD_SUF];
    }
    return [self initWithNibName:viewName bundle:nibBundleOrNil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.view.backgroundColor = [UIColor blackColor];
    self.navigator = (NavigationController*)self.navigationController;
}

- (void) viewDidUnload {
    self.imagename = nil;
    self.navigator = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
