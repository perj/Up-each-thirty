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
	[standingLabel setHidden:NO];
	[standingButton setHidden:NO];
	[cancelButton setHidden:NO];
	[standingButton setEnabled:YES];
	[standCounterLabel setHidden:YES];
	[standupWindow setFrame:NSMakeRect(0, 0, 480, 270) display:NO];
	[standupWindow center];
	[standupWindow orderFrontRegardless];
}

- (IBAction)startStandup:(id)sender
{
	[standingButton setEnabled:NO];
	[standingLabel setHidden:YES];
	[standingButton setHidden:YES];
	[cancelButton setHidden:YES];
	[standCounterLabel setHidden:NO];
	[standupWindow setFrame:NSMakeRect(0, 0, 120, 60) display:YES animate:YES];
	//[standCounterLabel setFrameOrigin:NSMakePoint(50, 50)];
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
	
	sitcounter.length = 29 * 60;
	standcounter.length = 60;
	
	standCounterFrame = [standCounterLabel frame];
	[standCounterLabel removeConstraints:[standCounterLabel constraints]];
	
	[sitcounter reset];
	sitcounter.counting = YES;
}

@synthesize mainWindow;

@synthesize standupWindow;
@synthesize standingButton;
@synthesize standingLabel;
@synthesize cancelButton;
@synthesize standCounterLabel;

@synthesize sitcounter;
@synthesize standcounter;

@end
