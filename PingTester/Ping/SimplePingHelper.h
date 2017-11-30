//
//  SimplePingHelper.h
//  PingTester
//
//  Created by Chris Hulbert on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePing.h"

typedef void(^CompletionHandler)(BOOL success, NSString * _Nullable reaseon);

@interface SimplePingHelper : NSObject <SimplePingDelegate>

/// Default timeout is 1 second.
@property (nonatomic, assign) int timeout;
@property (nonatomic, copy) CompletionHandler _Nullable completionHandler;

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithAddress:(NSString * _Nonnull)address completionHandler:(CompletionHandler _Nullable)handler NS_DESIGNATED_INITIALIZER;

/// Pings the address
- (void)ping;

@end

@interface SimplePingHelper (Convenience)

/// Pings the address, and calls the completionHandler when done.
/// Default timeout is 1 second.
+ (void)ping:(NSString * _Nonnull)address completionHandler:(CompletionHandler _Nullable)completionHandler;

@end
