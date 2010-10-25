//
//  FlashCardAppDelegate.m
//  FlashCard
//
//  Created by Logan Moseley on 6/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlashCardAppDelegate.h"
#import "AppViewController.h"
#import "CardViewController.h"

@implementation FlashCardAppDelegate

@synthesize window, appViewController;
@synthesize cardArray;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	[self loadCards];
	currentCard = 0;
	
	[window addSubview:appViewController.view];
    [window makeKeyAndVisible];
	

	return YES;
}


- (void)loadCards {
	NSLog(@"LOADING CARDS");
	NSString *bundleStr = [[[NSBundle mainBundle] bundlePath] autorelease];
	NSString *cardDictPath = [bundleStr stringByAppendingPathComponent:@"words.plist"];
	self.cardArray = [NSMutableArray arrayWithContentsOfFile:cardDictPath];
	
	[appViewController loadCardsDidFinish];
}


- (void)printCards {
	NSLog(@"PRINTING CARDS:");
	
	NSEnumerator *e = [cardArray objectEnumerator];	// crashes if we "autorelease" this one. must do it itself when done with the array.
	NSDictionary *tempDict = nil;//[[[NSDictionary alloc] init] autorelease];
	
	while (tempDict = [e nextObject]) {
		NSString *frontStr = [tempDict objectForKey:@"Front"];
		NSString *backStr = [tempDict objectForKey:@"Back"];
		
		NSLog(@"%@ :: %@", frontStr, backStr);
	}
}


- (void)shuffleCards {
	NSLog(@"SHUFFLING CARDS");
	
	NSUInteger count = [cardArray count];
	
	for (NSUInteger i = 0; i < count; ++i) {
		int nElements = count - i;
		int n = (arc4random() % nElements) + i;
		[cardArray exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
//	[self printCards];
}


// Returns NSDictionary (Front, Back) of next card.
- (NSDictionary*)getNextCard {
	currentCard++;
	if (currentCard >= [cardArray count]) {
		currentCard = 0;
	}
	NSLog(@"getNextCard with currentCard = %u", currentCard);	
	return [cardArray objectAtIndex:currentCard];
}


// Returns NSDictionary (Front, Back) of previous card.
- (NSDictionary*)getPrevCard{	
	currentCard--;
	if(currentCard < 0) {
		currentCard = [cardArray count] - 1;
	}
	NSLog(@"getPrevCard with currentCard = %u", currentCard);
	return [cardArray objectAtIndex:currentCard];
}

/*
 /*	getCardText:forSide
 /*
 /*	Args
 /*		whichDirection: either -1,0,1; corresponds to Previous, Current, Next
 /*		whichSide: either @"Front" or @"Back"; corresponds to Front, Back
 /*
 /* Returns
 /*		NSString: whichDirection card's whichSide's text
 */
- (NSString*)getCardText:(NSInteger)whichDirection forSide:(NSString*)whichSide {
	
	//	NSLog(@"currentCard = %d", currentCard);
	
	// Error check whichSide
	if (whichSide != @"Front" && whichSide != @"Back") {
		return @"Bad input to getCardText:forSide:";
	}
	
	currentCard -= whichDirection;
	if (currentCard < 0) {
		currentCard = [cardArray count] - 1;
	} else if (currentCard >= [cardArray count]) {
		currentCard = 0;
	}
	
	NSDictionary *tempDict = [cardArray objectAtIndex:currentCard];
	NSString *tempStr = [tempDict objectForKey:whichSide];
	
	return tempStr;	
}


- (void)sayHi {
	NSLog(@"HELLO FROM APP DELEGATE");
}


/*
- (void)applicationWillTerminate:(UIApplication *)application {
}
 */


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [appViewController release];
    [window release];
	[cardArray release];
    [super dealloc];
}

@end
