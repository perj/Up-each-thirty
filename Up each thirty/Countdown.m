//
//  Countdown.m
//  Up each thirty
//
//  Created by Per Johansson on 2012-05-05.
//  Copyright (c) 2012 Per Johansson. All rights reserved.
//

#import "Countdown.h"

@implementation Countdown

- (id)init
{
	self = [super init];
	if (self)
	{
		self.updateInterval = 0.5;
	}
	return self;
}

- (void)updateTimeLeft
{
	NSTimeInterval tl = [nextFire timeIntervalSinceNow];
	
	if (tl < 0)
		tl = 0;
	else
		tl = round(tl);
	
	self.timeLeft = [NSString stringWithFormat:@"%02d:%02d", (int)tl / 60, (int)tl % 60];
	if (!tl)
		[self fire];
}

- (void)reset
{
	self.counting = NO;
	self.nextFire = [NSDate dateWithTimeIntervalSinceNow:self.length];
	[self updateTimeLeft];
}

- (void)fire
{
	self.counting = NO;
	self.nextFire = [NSDate date];
	self.timeLeft = @"00:00";
	
	[NSApp sendAction:action to:target from:self];
}

- (void)setTicker
{
	[ticker invalidate];
	if (counting && nextFire && updateInterval > 0)
		ticker = [NSTimer scheduledTimerWithTimeInterval:updateInterval target:self selector:@selector(updateTimeLeft) userInfo:nil repeats:YES];
	else
		ticker = nil;
}

- (void)setUpdateInterval:(NSTimeInterval)ui
{
	if (ui <= 0)
		[NSException raise:@"Bad update interval" format:@"%lf <= 0", ui];
	
	updateInterval = ui;
	[self setTicker];
}

- (NSTimeInterval)updateInterval
{
	return updateInterval;
}

- (void)setCounting:(BOOL)c
{
	counting = c;
	[self setTicker];
}

- (BOOL)counting
{
	return counting;
}

- (void)setNextFire:(NSDate *)nf
{
	nextFire = nf;
	[self setTicker];
}

- (NSDate *)nextFire
{
	return nextFire;
}

@synthesize length;
@synthesize timeLeft;

@synthesize target;
@synthesize action;

@end
