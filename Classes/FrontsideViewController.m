//
//  FrontsideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FrontsideViewController.h"


@implementation FrontsideViewController

@synthesize delegate, frontLabel, frontText, backText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.frontText = @"Calamity";
	self.backText = @"A force of nature to change the world!";
	[self replaceLabel:frontText];
}

#pragma mark Flippy

- (void)backsideViewControllerDidFinish:(BacksideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)flipToBack {
	
	BacksideViewController *controller = [[BacksideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	controller.backText = self.backText;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
		
	[controller release];
}


#pragma mark Card Management

- (void)replaceWithNext {
	NSDictionary *tempDict = [delegate getNextCard];
	frontText = [tempDict objectForKey:@"Front"];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceLabel:frontText];
}

-(void)replaceWithPrev{
	NSDictionary *tempDict = [delegate getPrevCard];
	frontText = [tempDict objectForKey:@"Front"];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceLabel:frontText];
}


- (void)replaceLabel:(NSString*)_frontText {
	self.frontLabel.text = _frontText;
}


- (NSDictionary*)getNextCard {
	return [delegate getNextCard];
}

- (NSDictionary*)getPrevCard {
	return [delegate getPrevCard];
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
	[frontLabel release];
	[frontText release];
	[backText release];
    [super dealloc];
}


@end


