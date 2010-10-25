//
//  FrontsideViewController.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CardViewController.h"


@implementation CardViewController

@synthesize delegate, prevBgImageView, bgImageView, nextBgImageView;
@synthesize textStr, textLabel, nextLabel, prevLabel;

#define kTextSwitchDelay	0.7

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	// Find the paper sound
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"page_turn_4" ofType:@"wav"];
	
	if(soundPath)
	{
		NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
		
		OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &pageTurn);
		
		if (err != kAudioServicesNoError)
			NSLog(@"Could not load %@, error code: %d", soundURL, err);
	}
	
	[super viewDidLoad];
	textLabel.text = textStr;
	textLabel.numberOfLines = 0;
	nextLabel.numberOfLines = 0;
	prevLabel.numberOfLines = 0;
	NSLog(@"Hello viewDidLoad");
}



#pragma mark Text Management


/*
 * Replace the text without animation.
 */
- (void)replaceLabel:(NSString*)newLabelText {
	
	/*NSMutableString *process = [[NSMutableString alloc] init];
	[process setString:newLabelText];
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
	}*/
	textStr = [self insertLineBreaks:newLabelText];
	textLabel.text = textStr;
	NSLog(@"Swapped labels");
}

- (NSString *)insertLineBreaks:(NSString *)textToChange{
	
	NSMutableString *process = [[NSMutableString alloc] initWithString:textToChange];
//	[process setString:textToChange];	// setString: may need to only be done on an NSMutableString that was
										// initWithCapacity.  That's what happens in the sample project (from xcode docs).
//	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	// collect the memory leak below
	NSInteger strLength = [process length];
	if (strLength > 25) {
		for (NSInteger i = 15; i < strLength; i++) {
			char c = [process characterAtIndex:i];
			if( c == 32){				
				NSLog(@"Found a space at %i", i);
				[process insertString:@"\n" atIndex:i];	// memory leak here. something about NSPlaceholderMutableString.
				i += 15;
			}
		}
	}
//	[pool release];
	return (NSString*) process;
}
/*
 * Animate switching to the next label (word or definition).
 * Slides the layers left to right.
 */
- (void)replaceWithNextLabel:(NSString *)newLabelText {
	
	textStr = newLabelText;
	
	nextLabel.text = [self insertLineBreaks:textStr];
	
	{ /* Animation Block */
		// Create animation, define the transform direction
		CABasicAnimation *slide = 
		[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		[slide setDelegate:self];
		
		// Distance, duration of transform
		[slide setToValue:[NSNumber numberWithFloat:480]];
		[slide setDuration:0.75];
		
		// Notify delegate, which disables User Interaction (touches)
		[delegate animationWillStart:slide];
		
		// These layers will be animated
		[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[nextLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[bgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
		[[nextBgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
		
		// Play sound effect
		AudioServicesPlaySystemSound(pageTurn);
		
		[NSTimer scheduledTimerWithTimeInterval:kTextSwitchDelay
										 target:self
									   selector:@selector(invokeReplaceLabel:)
									   userInfo:nil
										repeats:NO];
		
	} /* End Animation Block */
}

- (void) invokeReplaceLabel:(NSTimer *)timer{
	[self replaceLabel:textStr];
}

/*
 * Animate switching to the previous label (word or definition).
 * Slides the layers right to left.
 */
- (void)replaceWithPrevLabel:(NSString *)newLabelText {
	
	textStr = newLabelText;
	
	prevLabel.text = [self insertLineBreaks:textStr];
	
	{ /* Animation Block */
		// Create animation, define the transform direction
		CABasicAnimation *slide = 
		[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		[slide setDelegate:self];
		
		// Distance, duration of transform
		[slide setToValue:[NSNumber numberWithFloat:-480]];
		[slide setDuration:0.75];
		
		// Notify delegate, which disables User Interaction (touches)
		[delegate animationWillStart:slide];
		
		// These layers will be animated
		[[textLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[prevLabel layer] addAnimation:slide forKey:@"slideAnimation"];
		[[bgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
		[[prevBgImageView layer] addAnimation:slide forKey:@"slideAnimation"];
		
		// Play Sound Effect
		AudioServicesPlaySystemSound(pageTurn);
		
		[NSTimer scheduledTimerWithTimeInterval:kTextSwitchDelay
										 target:self
									   selector:@selector(invokeReplaceLabel:)
									   userInfo:nil
										repeats:NO];
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
	
	[nextBgImageView release];
	[bgImageView release];
	[prevBgImageView release];
	
    [super dealloc];
}


@end


