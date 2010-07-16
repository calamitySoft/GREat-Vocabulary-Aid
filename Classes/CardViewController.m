//
//  FrontsideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CardViewController.h"


@implementation CardViewController

@synthesize delegate, textLabel, textStr, nextLabel, prevLabel;


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

- (void)replaceLabel:(NSString*)newLabelText {
	
	textStr = newLabelText;
	
	textLabel.text = textStr;
}

- (void)replaceWithNextLabel:(NSString *)newLabelText{
	
	textStr = newLabelText;
	
	nextLabel.text = textStr;
	
	CABasicAnimation *slide = 
	[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	
	[slide setToValue:[NSNumber numberWithFloat:480]];
	[slide setDuration:1.0];
	
	[slide setDelegate:self];
	
	[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
	[[nextLabel layer] addAnimation:slide forKey:@"slideAnimation"];
	
}

- (void)replaceWithLastLabel:(NSString *)newLabelText{
	
	textStr = newLabelText;
	
	prevLabel.text = textStr;
	
	CABasicAnimation *slide = 
	[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	
	[slide setToValue:[NSNumber numberWithFloat:-480]];
	[slide setDuration:1.0];
	
	[slide setDelegate:self];
	
	[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
	[[prevLabel layer] addAnimation:slide forKey:@"slideAnimation"];
	
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	NSLog(@"Animation did stop");
	textLabel.text = textStr;
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
	[textLabel release];
	[textStr release];
    [super dealloc];
}


@end


