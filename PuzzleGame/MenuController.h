//
//  MenuController.h
//  PuzzleGame
//
//  Created by Roman on 29.01.13.
//  Copyright (c) 2013 Appija LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"

#import "GameIcon.h"

#import "MKStoreManager.h"

@interface MenuController : BaseController<MKStoreKitDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *viewIconsList;

@end
