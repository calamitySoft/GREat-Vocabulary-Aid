//
//  FrontsideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CardViewController.h"


@implementation CardViewController

@synthesize delegate, bgImageView, textStr;
@synthesize textLabel, nextLabel, prevLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	textLabel.text = textStr;
	NSLog(@"Hello viewDidLoad");
}



#pragma mark Text Management


/*
 * Replace the text without animation.
 */
- (void)replaceLabel:(NSString*)newLabelText {
	textStr = newLabelText;
	textLabel.text = textStr;
}


/*
 * Animate switching to the next label (word or definition).
 * Slides the layers left to right.
 */
- (void)replaceWithNextLabel:(NSString *)newLabelText {
	
	textStr = newLabelText;
	
	nextLabel.text = textStr;
	
	{ /* Animation Block */
		// Create animation, define the transform direction
		CABasicAnimation *slide = 
		[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		[slide setDelegate:self];
		
		// Distance, duration of transform
		[slide setToValue:[NSNumber numberWithFloat:480]];
		[slide setDuration:1.0];
		
		// Notify delegate, which disables User Interaction (touches)
		[delegate animationWillStart:slide];
		
		// These layers will be animated
		[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[nextLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[bgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
	} /* End Animation Block */
}


/*
 * Animate switching to the previous label (word or definition).
 * Slides the layers right to left.
 */
- (void)replaceWithPrevLabel:(NSString *)newLabelText {
	
	textStr = newLabelText;
	
	prevLabel.text = textStr;
	
	{ /* Animation Block */
		// Create animation, define the transform direction
		CABasicAnimation *slide = 
		[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		[slide setDelegate:self];
		
		// Distance, duration of transform
		[slide setToValue:[NSNumber numberWithFloat:-480]];
		[slide setDuration:1.0];
		
		// Notify delegate, which disables User Interaction (touches)
		[delegate animationWillStart:slide];
		
		// These layers will be animated
		[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[prevLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[bgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
	} /* End Animation Block */
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	NSLog(@"Animation did stop");
	textLabel.text = textStr;
	
	// Notify delegate, which re-enables User Interaction (touches)
	[delegate animationDidStop:anim finished:flag];
}



#pragma mark Admin Stuff


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
			|| interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



- (void)dealloc {
	[prevLabel release];
	[nextLabel release];
	[textLabel release];
	[textStr release];
	[bgImageView release];
    [super dealloc];
}


@end


