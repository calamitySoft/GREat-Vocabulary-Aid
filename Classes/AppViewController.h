//
//  AppViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"

@protocol AppViewControllerDelegate;

@interface AppViewController : UIViewController <CardViewControllerDelegate> {
	id <AppViewControllerDelegate> delegate;
	
	CardViewController *frontsideViewController;
	CardViewController *backsideViewController;
	
	CGPoint touchBegan;
}

@property (nonatomic, retain) <AppViewControllerDelegate> delegate;

@property (nonatomic, retain) CardViewController *frontsideViewController;
@property (nonatomic, retain) CardViewController *backsideViewController;


- (IBAction)flipCard;
- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
- (BOOL)isFrontShown;

- (NSString*)getPrevCard;
- (void)replaceWithPrevCard;
- (NSString*)getCurrentCard;
- (void)replaceWithCurrentCard;
- (NSString*)getNextCard;
- (IBAction)replaceWithNextCard;
- (void)replaceLabel:(NSString *)newLabelText forSide:(NSString*)whichSide;
- (void)replaceLabel:(NSString*)newLabelText;
- (IBAction)shuffleCards;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@protocol AppViewControllerDelegate
- (void)shuffleCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (NSString*)getCardText:(NSInteger)whichDirection forSide:(NSString*)whichSide;
- (void)sayHi;
@end

