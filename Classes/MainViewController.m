//
//  MainViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize delegate, frontLabel, frontText, backText;

#define kSwipeXDistance		60 //px
#define kSwipeYDistance		40 //px


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
	[self replaceFrontLabel:frontText];
}

#pragma mark Flippy

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)flipToBack {
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	controller.backText = self.backText;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
		
	[controller release];
}


#pragma mark Card Management

- (IBAction)replaceWithNext {
	NSDictionary *tempDict = [delegate getNextCard];
	frontText = [tempDict objectForKey:@"Front"];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceFrontLabel:frontText];
}

-(IBAction)replaceWithPrev{
	NSDictionary *tempDict = [delegate getPrevCard];
	frontText = [tempDict objectForKey:@"Front"];
	backText = [tempDict objectForKey:@"Back"];
	
	[self replaceFrontLabel:frontText];
}


- (void)replaceFrontLabel:(NSString*)_frontText {
	self.frontLabel.text = _frontText;
}


- (IBAction)shuffleCards {
	[delegate shuffleCards];
}


- (NSDictionary*)getNextCard{
	return [delegate getNextCard];
}

- (NSDictionary*)getPrevCard{
	return [delegate getPrevCard];
}


# pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchBegan = [[touches anyObject] locationInView:self.view];	
//	NSLog(@"main | began | touchPoint: %@", NSStringFromCGPoint(touchBegan));
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {	
	CGPoint touchMoved = [[touches anyObject] locationInView:self.view];
//	NSLog(@"main | moved | touchPoint: %@", NSStringFromCGPoint(touchBegan));

	// Swipe > 30 left or right switches words
	if (abs(touchMoved.x-touchBegan.x) > kSwipeXDistance) {
//		NSLog(@"touchMoved x main");
		if (touchMoved.x - touchBegan.x > 0) {
			[self replaceWithNext];
		}
		else {
			[self replaceWithPrev];
		}

		touchBegan = touchMoved;// CGPointMake(0, 0);
	}
	// Swipe > 20 up or down flips the card
	else if (abs(touchMoved.y-touchBegan.y) > kSwipeYDistance) {
//		NSLog(@"touchMoved y main");
		[self flipToBack];
		touchBegan = CGPointMake(0, 0);
	}
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


