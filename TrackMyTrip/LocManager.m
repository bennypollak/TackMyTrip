//
//  LocationMgr.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocManager.h"
#import "LocHistoryDB.h"

@implementation LocManager {
    CLLocationManager *locationManager;
}
@synthesize active, sigOnly, currentIdent;

LocManager *instance;

- (id)init {
    self = [super init];
    if(nil != self) {
    }
    instance = self;
    return self;
}

-(void)initLocation {
    // Create the manager object 
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;

    // attempt to acquire location and thus, the amount of power that will be consumed.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 10.0;//kCLDistanceFilterNone;
    
    active = 0;
    sigOnly = 0;
    currentIdent = @"";
}

+ (LocManager*)sharedInstance {
    if (instance  == nil) {
        instance = [[LocManager alloc]init];
    }
    return instance;
}

-(void)startTracking {
    active = 1;
    if (sigOnly) {
        [locationManager startMonitoringSignificantLocationChanges];
    } else {
        [locationManager startUpdatingLocation];
    }
}

-(void)stopTracking {
    active = 0;
    if (sigOnly) {
        [locationManager stopMonitoringSignificantLocationChanges];
    } else {
        [locationManager stopUpdatingLocation];
    }
}

-(void)setDistanceFilter:(double)filter {
    locationManager.distanceFilter = filter;
    [self restartTracking];
}
-(double)distanceFilter {
    return locationManager.distanceFilter;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [[LocHistoryDB sharedInstance ]insertLoation:newLocation forIdent:currentIdent];
    
}

-(void)restartTracking {
    [self stopTracking];
    [self startTracking];
    
}


@end
