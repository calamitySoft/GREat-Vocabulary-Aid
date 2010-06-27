//
//  BacksideViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BacksideViewControllerDelegate;


@interface BacksideViewController : UIViewController {
	id <BacksideViewControllerDelegate> delegate;
	UILabel *backLabel;
	NSString *backText;
}

@property (nonatomic, assign) id <BacksideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *backLabel;
@property (nonatomic, retain) NSString *backText;

- (void)flipToFront;
- (void)replaceWithNext;
- (void)replaceWithPrev;
- (void)replaceLabel:(NSString*)_backText;

@end


@protocol BacksideViewControllerDelegate
- (void)backsideViewControllerDidFinish:(BacksideViewController *)controller;
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
@end

