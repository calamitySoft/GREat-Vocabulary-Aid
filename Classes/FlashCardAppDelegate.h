// MY EDIT not from the server



//
//  FlashCardAppDelegate.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "FlipsideViewController.h"

@class MainViewController;

@interface FlashCardAppDelegate : NSObject <UIApplicationDelegate, MainViewControllerDelegate> {	
	UIWindow *window;
    MainViewController *mainViewController;
	NSMutableArray *cardArray;
	
	NSInteger currCard;
	NSInteger DeleteMe;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSMutableArray *cardArray;

- (void)loadCards;
- (void)printCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (void)shuffleCards;

@end

