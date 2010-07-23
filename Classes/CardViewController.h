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

	UIImageView *prevBgImageView;
	UIImageView *bgImageView;
	UIImageView *nextBgImageView;
	
	NSString *textStr;
	UILabel *nextLabel;
	UILabel *textLabel;
	UILabel *prevLabel;
}

@property (nonatomic, assign) <CardViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *prevBgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *nextBgImageView;
@property (nonatomic, retain) NSString *textStr;
@property (nonatomic, retain) IBOutlet UILabel *nextLabel;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *prevLabel;

- (void)replaceLabel:(NSString*)newLabelText;
- (void)replaceWithNextLabel:(NSString *)newLabelText;
- (void)replaceWithPrevLabel:(NSString *)newLabelText;

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
- (void)invokeReplaceLabel:(NSTimer *)timer;
@end


@protocol CardViewControllerDelegate
// Animation response
- (void)animationWillStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end