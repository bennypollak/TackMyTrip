//
//  Trip.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Trip : NSObject
-(Trip*) initWithIdent:(NSString*)newIdent;

@property (nonatomic, readonly, copy) NSString *ident;

-(void)addLocation:(CLLocationCoordinate2D)coordinate atDate:(NSString*)atDate;


-(NSArray*)getDates;
-(NSArray*)getCoordinates;

-(NSString*)getStartTime;
-(NSString*)getEndTime;

@end
