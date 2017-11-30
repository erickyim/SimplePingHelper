//
//  SimplePingHelper.m
//  PingTester
//
//  Created by Chris Hulbert on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimplePingHelper.h"

@interface SimplePingHelper ()
@property(nonatomic,retain) SimplePing* simplePing;

@end

@implementation SimplePingHelper

#pragma mark - Run it

// Pings the address, and calls the completionHandler when done.
+ (void)ping:(NSString *)address completionHandler:(CompletionHandler)completionHandler {
    SimplePingHelper *pingHelper = [[SimplePingHelper alloc] initWithAddress:address completionHandler:completionHandler];
    [pingHelper ping];
}

#pragma mark - Init/dealloc

- (void)dealloc {
    self.simplePing.delegate = nil;
    self.simplePing = nil;
    self.completionHandler = nil;
}

- (instancetype)initWithAddress:(NSString *)address completionHandler:(CompletionHandler)handler {
    if (self = [super init]) {
        self.simplePing = [SimplePing simplePingWithHostName:address];
        self.simplePing.delegate = self;
        self.completionHandler = handler;
    }
    return self;
}

#pragma mark - Go

- (void)ping {
    [self.simplePing start];
    [self performSelector:@selector(endTime) withObject:nil afterDelay:self.timeout ?: 1]; // This timeout is what retains the ping helper
}

#pragma mark - Finishing and timing out

// Called on success or failure to clean up
- (void)killPing {
    [self.simplePing stop];
    self.simplePing = nil;
}

- (void)successPing {
    [self killPing];
    if (self.completionHandler) {
        self.completionHandler(YES, nil);
    }
}

- (void)failPing:(NSString *)reason {
    [self killPing];
    if (self.completionHandler) {
        self.completionHandler(NO, reason);
    }
}

// Called 1s after ping start, to check if it timed out
- (void)endTime {
    if (self.simplePing) { // If it hasn't already been killed, then it's timed out
        [self failPing:@"timeout"];
    }
}

#pragma mark - Pinger delegate

// When the pinger starts, send the ping immediately
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address {
    [self.simplePing sendPingWithData:nil];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error {
    [self failPing:@"didFailWithError"];
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet error:(NSError *)error {
    // Eg they're not connected to any network
    [self failPing:@"didFailToSendPacket"];
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet {
    [self successPing];
}

@end
