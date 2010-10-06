    //
//  AppViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"
#import "CardViewController.h"


@implementation AppViewController

@synthesize delegate;
@synthesize frontsideViewController, backsideViewController;

#define kSwipeXDistance		60	// px
#define kSwipeYDistance		40	// px

#define kPrevCard			-1	// card selection from delegate
#define kCurrentCard		0	// same
#define kNextCard			1	// same

#define kFront				@"Front"	// card selection from delegate
#define kBack				@"Back"		// same


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
	
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"page_turn_5" ofType:@"wav"];
	
	if(soundPath)
	{
		NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
		
		OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &pageFlip);
		
		if (err != kAudioServicesNoError)
			NSLog(@"Could not load %@, error code: %d", soundURL, err);
	}
	// Create and set the frontside view controller
	CardViewController *aController = [[CardViewController alloc] initWithNibName:@"FrontsideView" bundle:nil];
	aController.delegate = self;
	frontsideViewController.textStr = [self getCurrentCardForSide:kFront];
	self.frontsideViewController = aController;
	[aController release];
	
	NSLog(@"card = %@", [self getCurrentCardForSide:kFront]);
	
	[self.view insertSubview:self.frontsideViewController.view atIndex:0];
}


# pragma mark Interface

- (IBAction)flipCard{
	
	// Controllers of card views //
	CardViewController *coming;
	CardViewController *going;
	
	// If the front is currently visible
	if ([self isFrontShown]) {
		NSLog(@"Flipping to back");
		
		// Create and set the backside view controller		
		CardViewController *bController = [[CardViewController alloc] initWithNibName:@"BacksideView" bundle:nil];
		bController.delegate = self;
		bController.textStr = [self getCurrentCardForSide:kBack];
		bController.textStr = [self insertLineBreaks:bController.textStr];
		self.backsideViewController = bController;
		[bController release];
		
		// Declare which controller to flip to/from
		coming = backsideViewController;
		going = frontsideViewController;
		
		// I will switch to back
	} 
	
	// If the back is currently visible
	else if (![self isFrontShown]) {
		NSLog(@"Flipping to front");
		
		// Create and set the frontside view controller		
		CardViewController *fController = [[CardViewController alloc] initWithNibName:@"FrontsideView" bundle:nil];
		fController.delegate = self;
		fController.textStr = [self getCurrentCardForSide:kFront];
		self.frontsideViewController = fController;
		[fController release];
		
		// Declare which controller to flip to/from
		coming = frontsideViewController;
		going = backsideViewController;
		
		// I will switch to front
	}
	
	// If we don't know what's going on
	else {
		NSLog(@"isFrontShown not returning properly. I don't know what to do.");
		exit(0);
	}
	
	
	// This flip animation settings //
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	// Play the flipping sound
	
	AudioServicesPlaySystemSound(pageFlip);
	
	// self receives call-backs //
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
	self.view.userInteractionEnabled = FALSE;
	
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[coming viewWillAppear:YES];
	[going viewWillDisappear:YES];
	
	[going.view removeFromSuperview];
	[self.view insertSubview:coming.view atIndex:0];
	
	[going viewDidDisappear:YES];
	[coming viewDidAppear:YES];
	
	[UIView commitAnimations];
	
	
	// Make unseen card nil
	if ([self isFrontShown]) {
		backsideViewController = nil;
	} else {
		frontsideViewController = nil;
	}
}


- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	self.view.userInteractionEnabled = TRUE;
	
	// Double check the text.
	// May remove this if text is stable.
	if ([self isFrontShown]) {
		[frontsideViewController replaceLabel:[self getCurrentCard]];
	} else {
		[backsideViewController replaceLabel:[self getCurrentCard]];
	}

}

- (BOOL)isFrontShown {
	if (self.frontsideViewController.view.superview != nil )
		return TRUE;
	else
		return FALSE;
}


#pragma mark Card Management

// Previous card stuff //
- (void)replaceWithPrevCard {
	[self replaceLabel:[self getPrevCard] withDirection:kPrevCard];
}

- (NSString*)getPrevCard {
	if ([self isFrontShown]) {
		return [self getPrevCardForSide:kFront];
	} else {
		return [self getPrevCardForSide:kBack];
	}
}

- (NSString*)getPrevCardForSide:(NSString*)whichSide {
	return [delegate getCardText:kPrevCard forSide:whichSide];
}


// Current card stuff //
- (void)replaceWithCurrentCard {
	[self replaceLabel:[self getCurrentCard] withDirection:kCurrentCard];
}

- (NSString *)insertLineBreaks:(NSString *)textToChange{
	
	NSMutableString *process = [[NSMutableString alloc] init];
	[process setString:textToChange];
	NSInteger strLength = [process length];
	if (strLength > 25) {
		for (NSInteger i = 15; i < strLength; i++) {
			char c = [process characterAtIndex:i];
			if( c == 32){				
				NSLog(@"Found a space at %i", i);
				[process insertString:@"\n" atIndex:i];
				i += 15;
			}
		}
	}
	NSString *returnIt = process;
	return returnIt;
}


- (NSString*)getCurrentCard {
	if ([self isFrontShown]) {
		return [self getCurrentCardForSide:kFront];
	} else {
		return [self getCurrentCardForSide:kBack];
	}
}

- (NSString*)getCurrentCardForSide:(NSString*)whichSide {
	return [delegate getCardText:kCurrentCard forSide:whichSide];
}


// Next card stuff //
- (IBAction)replaceWithNextCard {
	[self replaceLabel:[self getNextCard] withDirection:kNextCard];
}

- (NSString*)getNextCard {
	if ([self isFrontShown]) {
		return [self getNextCardForSide:kFront];
	} else {
		return [self getNextCardForSide:kBack];
	}
}

- (NSString*)getNextCardForSide:(NSString*)whichSide {
	return [delegate getCardText:kNextCard forSide:whichSide];
}


//- (void)replaceLabel:(NSString *)newLabelText forSide:(NSString*)whichSide {
//	if (whichSide == kFront) {
//		[frontsideViewController replaceLabel:newLabelText];
//	} else {
//		[backsideViewController replaceLabel:newLabelText];
//	}
//}


/*
 * Wrapper - tells current view controller to replace text.
 */
- (void)replaceLabel:(NSString*)newLabelText withDirection:(int)direction{
	// Replace front side.  This is animated for Next & Prev.
	if ([self isFrontShown]) {
		if (direction == kNextCard) {
			[frontsideViewController replaceWithNextLabel:newLabelText];
		}
		else if (direction == kPrevCard) {
			[frontsideViewController replaceWithPrevLabel:newLabelText];
		}
		else if (direction == kCurrentCard) {
			[frontsideViewController replaceLabel:newLabelText];
		}
		else {
			NSLog(@"Bad direction input: %d", direction);
		}

	}
	
	// Replace back side.  This is animated for Next & Prev.
	else {
		if (direction == kNextCard) {
			[backsideViewController replaceWithNextLabel:newLabelText];
		}
		else if (direction == kPrevCard) {
			[backsideViewController replaceWithPrevLabel:newLabelText];
		}
		else if (direction == kCurrentCard) {
			[backsideViewController replaceLabel:newLabelText];
		}
		else {
			NSLog(@"Bad direction input: %d", direction);
		}

	}
}


- (void)animationWillStart:(CAAnimation *)anim {
	self.view.userInteractionEnabled = FALSE;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	self.view.userInteractionEnabled = TRUE;
}


/*
 * Tells delegate to shuffle the deck.
 * Moves to the next card because the current text will be moved.
 */
- (IBAction)shuffleCards {
	[delegate shuffleCards];		// Shuffle the deck
	[self replaceWithNextCard];		// Move to the next card.
}



# pragma mark Touch Handling


/*
 * touchesBegan:withEvent: occurs when a new touch event
 * has begun
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchBegan = [[touches anyObject] locationInView:self.view];		// First location of touch contact
}


/*
 * touchesMoved:withEvent: occurs every update where there
 * is a touch event that was present and in a different
 * place on last update (i.e. touch was moved)
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.view.userInteractionEnabled) {			// I should not do anything if interaction is disabled.
		return;
	}
	
	CGPoint touchMoved = [[touches anyObject] locationInView:self.view];	// New location of moved touch point
	
	// Swipe > 30 left or right switches words
	if (abs(touchMoved.x-touchBegan.x) > kSwipeXDistance) {
		// Swiping right --> new card slides in from the left
		if (touchMoved.x-touchBegan.x > 0) {
			[self replaceWithNextCard];		// This looks a little wonky, but it works AppDelegate:112.
		}
		// Swiping left --> new card slides in from the right
		else {
			[self replaceWithPrevCard];
		}
		
		touchBegan = touchMoved;
	}
	
	// Swipe > 20 up or down flips the card
	else if (abs(touchMoved.y-touchBegan.y) > kSwipeYDistance) {
		[self flipCard];
		touchBegan = CGPointMake(0, 0);
	}
}



#pragma mark Admin Stuff


/*
 * Message received from AppDelegate when it has finished
 * loading cards
 */
- (void)loadCardsDidFinish {
	[self replaceWithCurrentCard];
}


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
	[frontsideViewController release];
	[backsideViewController release];
    [super dealloc];
}


@end
