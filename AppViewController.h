//
//  AppViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontsideViewController.h"
#import "BacksideViewController.h"

@protocol AppViewControllerDelegate;

@interface AppViewController : UIViewController <FrontsideViewControllerDelegate> {
	id <AppViewControllerDelegate> delegate;
	
	FrontsideViewController *frontsideViewController;
	BacksideViewController *backsideViewController;
	
	CGPoint touchBegan;
}

@property (nonatomic, retain) <AppViewControllerDelegate> delegate;

@property (nonatomic, retain) FrontsideViewController *frontsideViewController;
@property (nonatomic, retain) BacksideViewController *backsideViewController;


- (IBAction)flipCard;
- (IBAction)goToNextCard;
- (IBAction)shuffleCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@protocol AppViewControllerDelegate
- (void)shuffleCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (void)sayHi;
@end

