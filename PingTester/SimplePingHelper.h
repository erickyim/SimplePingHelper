//
//  SimplePingHelper.h
//  PingTester
//
//  Created by Chris Hulbert on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePing.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CompletionHandler)(BOOL success, NSString * _Nullable reaseon);

@interface SimplePingHelper : NSObject <SimplePingDelegate>

- (instancetype _Nullable )init NS_UNAVAILABLE;

/// Pings the address, and calls the completionHandler when done.
+ (void)ping:(NSString * _Nonnull)address completionHandler:(CompletionHandler _Nullable)completionHandler;

@end
NS_ASSUME_NONNULL_END
