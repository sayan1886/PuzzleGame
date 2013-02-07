//
//  MKStoreManager.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//  mugunthkumar.com
//

#import "MKStoreManager.h"


@implementation MKStoreManager

@synthesize purchasableObjects;
@synthesize storeObserver;
@synthesize delegate;

// all your features should be managed one and only by StoreManager
static NSString *addtitionalPuzzle = @"puzzle-0-1";

BOOL addtitionalPuzzlePurchased;

static MKStoreManager* _sharedStoreManager; // self

- (void)dealloc {
	_sharedStoreManager = nil;
	storeObserver = nil;
}

+ (BOOL) additionalPuzzlePurchased {
	return addtitionalPuzzlePurchased;
}


+ (MKStoreManager*)sharedManager {
	@synchronized(self) {
		
        if (_sharedStoreManager == nil) {
            [[self alloc] init]; // assignment not done here
			_sharedStoreManager.purchasableObjects = [[NSMutableArray alloc] init];			
			[_sharedStoreManager requestProductData];
			
			[MKStoreManager loadPurchases];
			_sharedStoreManager.storeObserver = [[MKStoreObserver alloc] init];
			[[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedStoreManager.storeObserver];
        }
    }
    return _sharedStoreManager;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone {	
    @synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            _sharedStoreManager = [super allocWithZone:zone];			
            return _sharedStoreManager;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void) requestProductData {
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: 
    [NSSet setWithObject: addtitionalPuzzle]]; // add any other product here
	request.delegate = self;
	[request start];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	[purchasableObjects addObjectsFromArray:response.products];
	// populate your UI Controls here
	for(int i=0;i<[purchasableObjects count];i++) {
		SKProduct *product = [purchasableObjects objectAtIndex:i];
		NSLog(@"Feature: %@, Cost: %f, ID: %@",[product localizedTitle],
			  [[product price] doubleValue], [product productIdentifier]);
	}
}

- (void) byeAdditionalPuzzle {
    [self buyPuzzles:addtitionalPuzzle];
}

- (void) buyPuzzles:(NSString*) puzzleId {
	if ([SKPaymentQueue canMakePayments]) {
		SKPayment *payment = [SKPayment paymentWithProductIdentifier:puzzleId];
		[[SKPaymentQueue defaultQueue] addPayment:payment];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cat Puzzle" message:@"You are not authorized to purchase from AppStore"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
}

-(void)paymentCanceled {
	if([delegate respondsToSelector:@selector(failed)]) {
        [delegate failed];
    }
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction {
	if([delegate respondsToSelector:@selector(failed)]) {
		[delegate failed];
    }
	
	NSString *messageToBeShown = [NSString stringWithFormat:@"Reason: %@, You can try: %@", [transaction.error localizedFailureReason], [transaction.error localizedRecoverySuggestion]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to complete your purchase" message:messageToBeShown
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

-(void) provideContent: (NSString*) productIdentifier {
	if([productIdentifier isEqualToString:addtitionalPuzzle]) {
		addtitionalPuzzlePurchased = YES;
		if([delegate respondsToSelector:@selector(productAPurchased)]) {
			[delegate additianlPuzzlePurchased];
        }
	}

	[MKStoreManager updatePurchases];
}


+(void) loadPurchases  {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];	
	addtitionalPuzzlePurchased = [userDefaults boolForKey:addtitionalPuzzle];
}


+(void) updatePurchases {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:addtitionalPuzzlePurchased forKey:addtitionalPuzzle];
}

@end
