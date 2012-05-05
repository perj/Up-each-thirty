//
//  AppDelegate.h
//  Up each thirty
//
//  Created by Per Johansson on 2012-05-05.
//  Copyright (c) 2012 Per Johansson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Countdown;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	BOOL counting;
	NSDate *nextStandup;
	NSTimeInterval updateInterval;
	NSTimer *ticker;
}

@property (assign) IBOutlet NSWindow *mainWindow;

@property (assign) IBOutlet NSWindow *standupWindow;
@property (assign) IBOutlet NSButton *standingButton;

@property (retain) Countdown *sitcounter;
@property (retain) Countdown *standcounter;

- (IBAction)startStandup:(id)sender;
- (IBAction)doneStandup:(id)sender;

@end
