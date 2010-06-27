//
//  FrontsideViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BacksideViewController.h"

@protocol FrontsideViewControllerDelegate;

@interface FrontsideViewController : UIViewController <BacksideViewControllerDelegate> {
	id <FrontsideViewControllerDelegate> delegate;
	UILabel *frontLabel;
	NSString *frontText;
	NSString *backText;
}

@property (nonatomic, assign) <FrontsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *frontLabel;
@property (nonatomic, retain) NSString *frontText;
@property (nonatomic, retain) NSString *backText;

- (void)flipToBack;
- (void)replaceWithNext;
- (void)replaceWithPrev;
- (void)replaceLabel:(NSString*)_frontText;

- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;

@end


@protocol FrontsideViewControllerDelegate
- (NSDictionary*)getNextCard;
- (NSDictionary*)getPrevCard;
@end