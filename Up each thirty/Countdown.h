//
//  Countdown.h
//  Up each thirty
//
//  Created by Per Johansson on 2012-05-05.
//  Copyright (c) 2012 Per Johansson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Countdown : NSObject

@property (assign) NSTimeInterval length;
@property (assign) BOOL counting;
@property (retain) NSDate *nextFire;

@property (retain) NSString *timeLeft;
@property (assign) int percent;

@property (assign) NSTimeInterval updateInterval;

@property (assign) id target;
@property (assign) SEL action;

- (void)fire;
- (void)reset;

@end
