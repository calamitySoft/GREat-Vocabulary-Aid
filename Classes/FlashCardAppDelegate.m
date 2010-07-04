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

//	appViewController.delegate = self;
	[window addSubview:appViewController.view];
    [window makeKeyAndVisible];
	
	[self loadCards];
	currentCard = 0;

	return YES;
}


- (void)loadCards {
	NSString *bundleStr = [[NSBundle mainBundle] bundlePath];
	NSString *cardDictPath = [bundleStr stringByAppendingPathComponent:@"words.plist"];
	self.cardArray = [NSMutableArray arrayWithContentsOfFile:cardDictPath];
}


- (void)printCards {
	NSLog(@"PRINTING CARDS:");
	
	NSEnumerator *e = [cardArray objectEnumerator];
	NSDictionary *tempDict;
	
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
		int n = (random() % nElements) + i;
		[cardArray exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
	//	[self printCards];
}


- (NSDictionary*)getNextCard {
	NSDictionary *tempDict = [cardArray objectAtIndex:currentCard];
	NSLog(@"getnextcard with currcard = %u", currentCard);

	currentCard++;
	if (currentCard >= [cardArray count]) {
		currentCard = 0;
	}
	NSLog(@"after: currcard = %u", currentCard);
	
	return tempDict;
}


- (NSDictionary*)getPrevCard{
	NSDictionary *tempDict = [cardArray objectAtIndex:currentCard];
	NSLog(@"getprevcard with currcard = %u", currentCard);
	
	currentCard--;
	if(currentCard <= 0) {
		currentCard = [cardArray count] - 1;
	}
	NSLog(@"after: currcard = %u", currentCard);
	
	return tempDict;
}

/*
 /*	getCardText:forSide
 /*
 /*	Args
 /*		whichDirection: either -1,0,1; corresponds to Previous, Current, Next
 /*		whichSide: either @"Front" or @"Back"; corresponds to Front, Back
 /*
 /* Returns
 /*		NSString: current card's current side's text
 */
- (NSString*)getCardText:(NSInteger)whichDirection forSide:(NSString*)whichSide {
	// Error check whichSide
	if (whichSide != @"Front" && whichSide != @"Back") {
		return @"Bad input";
	}
	
	currentCard += whichDirection;
	if (currentCard <= 0) {
		currentCard = [cardArray count] - 1;
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
