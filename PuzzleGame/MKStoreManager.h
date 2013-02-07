//
//  StoreManager.h
//  MKSync
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 MK Inc. All rights reserved.
//  mugunthkumar.com

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreObserver.h"

@protocol MKStoreKitDelegate <NSObject>
@optional
- (void)additianlPuzzlePurchased;
- (void)failed;
@end

@interface MKStoreManager : NSObject<SKProductsRequestDelegate> {
	NSMutableArray *purchasableObjects;
	MKStoreObserver *storeObserver;	
	id<MKStoreKitDelegate> delegate;
}

@property (nonatomic, retain) id<MKStoreKitDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (nonatomic, retain) MKStoreObserver *storeObserver;

- (void) requestProductData;

- (void) byeAdditionalPuzzle;

// do not call this directly. This is like a private method
- (void) buyPuzzles:(NSString*) puzzleId;

- (void)paymentCanceled;

- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) provideContent: (NSString*) productIdentifier;

+ (MKStoreManager*)sharedManager;

+ (BOOL) additionalPuzzlePurchased;

+ (void) loadPurchases;
+ (void) updatePurchases;

@end
