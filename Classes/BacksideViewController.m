//
//  BacksideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BacksideViewController.h"


@implementation BacksideViewController

@synthesize delegate, backLabel, backText;


- (void)viewDidLoad {
    [super viewDidLoad];
	[self replaceLabel:backText];
//    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
}


# pragma mark Flippy

- (void)flipToFront {
	[self.delegate backsideViewControllerDidFinish:self];	
}


# pragma mark Card Management

-(void)replaceWithNext {
	NSDictionary *tempDict = [delegate getNextCard];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceLabel:backText];
}

-(void)replaceWithPrev{
	NSDictionary *tempDict = [delegate getPrevCard];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceLabel:backText];
}

- (void)replaceLabel:(NSString*)_backText {
	self.backLabel.text = _backText;
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
