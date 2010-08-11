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


#pragma mark Interface
- (IBAction)flipCard;
- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
- (BOOL)isFrontShown;


#pragma mark Card Management
// Previous card
- (NSString*)getPrevCard;
- (NSString*)getPrevCardForSide:(NSString*)whichSide;
- (void)replaceWithPrevCard;
// Current card - for flipping
- (NSString*)getCurrentCard;
- (NSString*)getCurrentCardForSide:(NSString*)whichSide;
- (void)replaceWithCurrentCard;
- (NSString*)insertLineBreaks:(NSString*)textToChange;
// Next card
- (NSString*)getNextCard;
- (NSString*)getNextCardForSide:(NSString*)whichSide;
- (IBAction)replaceWithNextCard;
// Replace words
//- (void)replaceLabel:(NSString *)newLabelText forSide:(NSString*)whichSide;
- (void)replaceLabel:(NSString*)newLabelText withDirection:(int)direction;
- (IBAction)shuffleCards;
// Animation response
- (void)animationWillStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;


#pragma mark Touch Handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark Admin Stuff
- (void)loadCardsDidFinish;

@end



@protocol AppViewControllerDelegate
- (void)shuffleCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (NSString*)getCardText:(NSInteger)whichDirection forSide:(NSString*)whichSide;
- (void)sayHi;
@end

