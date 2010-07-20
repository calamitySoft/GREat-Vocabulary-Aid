//
//  FrontsideViewController.h
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol CardViewControllerDelegate;

@interface CardViewController : UIViewController {
	id <CardViewControllerDelegate> delegate;
	UILabel *textLabel;
	UILabel *nextLabel;
	UILabel *prevLabel;
	NSString *textStr;
}

@property (nonatomic, assign) <CardViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextLabel;
@property (nonatomic, retain) IBOutlet UILabel *prevLabel;
@property (nonatomic, retain) NSString *textStr;

- (void)replaceLabel:(NSString*)newLabelText;

- (void)replaceWithNextLabel:(NSString *)newLabelText;

- (void)replaceWithLastLabel:(NSString *)newLabelText;

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end


@protocol CardViewControllerDelegate
// Animation response
- (void)animationWillStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end