//
//  AppDelegate.m
//  Up each thirty
//
//  Created by Per Johansson on 2012-05-05.
//  Copyright (c) 2012 Per Johansson. All rights reserved.
//

#import "AppDelegate.h"
#import "Countdown.h"

@implementation AppDelegate

- (id)init
{
	self = [super init];
	if (self)
	{
		sitcounter = [[Countdown alloc] init];
		sitcounter.target = self;
		sitcounter.action = @selector(doStandup:);
		standcounter = [[Countdown alloc] init];
		standcounter.target = self;
		standcounter.action = @selector(doneStandup:);
	}
	return self;
}

- (void)doStandup:(id)sender
{
	[standcounter reset];
	[standingButton setEnabled:YES];
	[standupWindow orderFrontRegardless];
}

- (IBAction)startStandup:(id)sender
{
	[standingButton setEnabled:NO];
	[standcounter reset];
	standcounter.counting = YES;
}

- (IBAction)doneStandup:(id)sender
{
	[standupWindow close];
	[sitcounter reset];
	sitcounter.counting = YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[standupWindow setLevel:NSFloatingWindowLevel];
	
	sitcounter.length = 30 * 60;
	standcounter.length = 60;
	
	[sitcounter reset];
	sitcounter.counting = YES;
}

@synthesize mainWindow;

@synthesize standupWindow;
@synthesize standingButton;

@synthesize sitcounter;
@synthesize standcounter;

@end
