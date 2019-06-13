//
//  LocationMgr.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocManager : NSObject<CLLocationManagerDelegate>
- (id)init;
-(void)initLocation;

+ (LocManager*)sharedInstance;

@property (assign) BOOL active;
@property (assign) BOOL sigOnly;
@property (assign) double distanceFilter;

@property (retain) NSString *currentIdent;

-(void)restartTracking;
-(void)stopTracking;
-(void)startTracking;

@end
