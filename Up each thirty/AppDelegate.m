//
//  AppDelegate.m
//  Up each thirty
//
//  Created by Per Johansson on 2012-05-05.
//  Copyright (c) 2012 Per Johansson. All rights reserved.
//

#import "AppDelegate.h"
#import "Countdown.h"

enum observee
{
	obSitPercent,
	numObservees
};

@interface AppDelegate ()
{
	int icon;
	char obptrs[numObservees];
}

@end

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
	if (debug >= 1)
		NSLog(@"done standup: %@", sender);
	[standupWindow close];
	[sitcounter reset];
	sitcounter.counting = YES;
}

- (void)observeSitPercent
{
	int ic = ((sitcounter.percent * 30 / 100) + 2) / 5 * 5;
	
	if (debug >= 2)
		NSLog(@"perc %d", sitcounter.percent);
	
	if (ic != icon)
	{
		icon = ic;
		[NSApp setApplicationIconImage:[NSImage imageNamed:[NSString stringWithFormat:@"uet%d", icon]]];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	switch ((enum observee)((char*)context - obptrs))
	{
	case obSitPercent:
		[self observeSitPercent];
		break;
	default:
		/* Not for us */
		break;
	}
}

- (void)appDidDeactivate:(NSNotification *)sender
{
	NSRunningApplication *app = [[sender userInfo] valueForKey:NSWorkspaceApplicationKey];
	
	if ([app.bundleIdentifier isEqualToString:@"com.apple.ScreenSaver.Engine"])
		[self doneStandup:sender];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.debug = atoi(getenv("UET_DEBUG") ?: "0");
	
	[standupWindow setLevel:NSFloatingWindowLevel];
	
	[[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(doneStandup:) name:NSWorkspaceSessionDidBecomeActiveNotification object:nil];
	[[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(doneStandup:) name:NSWorkspaceDidWakeNotification object:nil];
	[[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(doneStandup:) name:NSWorkspaceScreensDidWakeNotification object:nil];
	[[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(appDidDeactivate:) name:NSWorkspaceDidDeactivateApplicationNotification object:nil];
	
	sitcounter.length = self.debug >= 1 ? 4 : 29 * 60;
	standcounter.length = self.debug >= 1 ? 4 : 60;
	
	[sitcounter reset];
	
	[sitcounter addObserver:self forKeyPath:@"percent" options:0 context:obptrs + obSitPercent];
	
	sitcounter.counting = YES;
}

@synthesize debug;

@synthesize mainWindow;

@synthesize standupWindow;
@synthesize standingButton;
@synthesize standingLabel;
@synthesize cancelButton;
@synthesize standCounterLabel;

@synthesize sitcounter;
@synthesize standcounter;

@end
