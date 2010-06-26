//
//  FlipsideViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	UILabel *backLabel;
	NSString *backText;
	
	CGPoint touchBegan;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *backLabel;
@property (nonatomic, retain) NSString *backText;

- (IBAction)flipToFront;
- (IBAction)replaceWithNext;
- (IBAction)replaceWithPrev;
- (void)replaceBackLabel:(NSString*)_backText;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
@end

