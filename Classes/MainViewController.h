//
//  MainViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlipsideViewController.h"

@protocol MainViewControllerDelegate;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	id <MainViewControllerDelegate> delegate;
	UILabel *frontLabel;
	NSString *frontText;
	NSString *backText;
	
	CGPoint touchBegan;
}

@property (nonatomic, assign) <MainViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *frontLabel;
@property (nonatomic, retain) NSString *frontText;
@property (nonatomic, retain) NSString *backText;

- (IBAction)flipToBack;
- (IBAction)replaceWithNext;
- (IBAction)replaceWithPrev;
- (void)replaceFrontLabel:(NSString*)_frontText;
- (IBAction)shuffleCards;

- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@protocol MainViewControllerDelegate
- (void)loadCards;
- (void)printCards;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
- (void)shuffleCards;
@end