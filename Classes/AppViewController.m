    //
//  AppViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"
#import "FrontsideViewController.h"
#import "BacksideViewController.h"


@implementation AppViewController

@synthesize delegate;
@synthesize frontsideViewController, backsideViewController;

#define kSwipeXDistance		60 //px
#define kSwipeYDistance		40 //px


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		
	FrontsideViewController *aController = [[FrontsideViewController alloc] initWithNibName:@"FrontsideView" bundle:nil];
	aController.delegate = self;
	self.frontsideViewController = aController;
	[aController release];
	
	[self.view insertSubview:self.frontsideViewController.view atIndex:0];
}


# pragma mark Interface

- (IBAction)flipCard{
	NSLog(@"I crash the program.\nChange this out of a modal view switch to a transition handled by me.");
//	[frontsideViewController flipToBack];
}

- (IBAction)goToNextCard {	

	NSDictionary *tempDict = [delegate getNextCard];
	NSString *_frontText = [tempDict objectForKey:@"Front"];
	
	[frontsideViewController replaceLabel:_frontText];
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
			[frontsideViewController replaceWithNext];
		}
		else {
			[frontsideViewController replaceWithPrev];
		}
		
		touchBegan = touchMoved;// CGPointMake(0, 0);
	}
	// Swipe > 20 up or down flips the card
	else if (abs(touchMoved.y-touchBegan.y) > kSwipeYDistance) {
		//		NSLog(@"touchMoved y main");
		[frontsideViewController flipToBack];
		touchBegan = CGPointMake(0, 0);
	}
}


#pragma mark Admin Stuff

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
			|| interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
