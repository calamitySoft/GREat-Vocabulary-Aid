//
//  FlashCardAppDelegate.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppViewController.h"
#import "CardViewController.h"

@class AppViewController;
@class CardViewController;

@interface FlashCardAppDelegate : NSObject <UIApplicationDelegate, AppViewControllerDelegate> {	
	IBOutlet UIWindow *window;
	IBOutlet AppViewController *appViewController;
	
	NSMutableArray *cardArray;
	NSInteger currentCard;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) AppViewController *appViewController;

@property (nonatomic, retain) NSMutableArray *cardArray;

- (void)loadCards;
- (void)printCards;
- (void)shuffleCards;

- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (NSString*)getCardText:(NSInteger)whichDirection forSide:(NSString*)whichSide;

- (void)sayHi;

@end

