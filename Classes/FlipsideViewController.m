//
//  FlipsideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate, backLabel, backText;

#define kSwipeXDistance		60 //px
#define kSwipeYDistance		40 //px


- (void)viewDidLoad {
    [super viewDidLoad];
	[self replaceBackLabel:backText];
//    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
}


# pragma mark Flippy

- (IBAction)flipToFront {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


# pragma mark Card Management

-(IBAction)replaceWithNext {
	NSDictionary *tempDict = [delegate getNextCard];
	//frontText = [tempDict objectForKey:@"Front"];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceBackLabel:backText];
}

-(IBAction)replaceWithPrev{
	NSDictionary *tempDict = [delegate getPrevCard];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceBackLabel:backText];
}

- (void)replaceBackLabel:(NSString*)_backText {
	self.backLabel.text = _backText;
}


# pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchBegan = [[touches anyObject] locationInView:self.view];
	NSLog(@"flip | began | touchPoint: %@", NSStringFromCGPoint(touchBegan));
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {	
	CGPoint touchMoved = [[touches anyObject] locationInView:self.view];
	NSLog(@"main | moved | touchPoint: %@", NSStringFromCGPoint(touchBegan));

	// Swipe > 30 left or right switches words
	if (abs(touchMoved.x-touchBegan.x) > kSwipeXDistance) {
//		NSLog(@"touchMoved x flip: %f", kSwipeXDistance);	//abs(touchMoved.x-touchBegan.x));

		if (touchMoved.x - touchBegan.x > 0) {
			[self replaceWithNext];
		}
		else {
			[self replaceWithPrev];
		}

		touchBegan = CGPointMake(0, 0);
	}
	// Swipe > 20 up or down flips the card
	else if (abs(touchMoved.y-touchBegan.y) > kSwipeYDistance) {
//		NSLog(@"touchMoved y flip: %f", kSwipeYDistance);
		[self flipToFront];
		touchBegan = CGPointMake(0, 0);
	}
}


#pragma mark Admin Stuff

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
			|| interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



- (void)dealloc {
    [super dealloc];
}


@end
