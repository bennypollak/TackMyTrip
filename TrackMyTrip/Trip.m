//
//  Trip.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Trip.h"



@implementation Trip 
{
    NSMutableArray *coordinates;
    NSMutableArray *dates;
}

@synthesize ident;

-(Trip*) initWithIdent:(NSString*)newIdent {
    self = [super init];
    if(nil != self) {
    }
    ident = newIdent;
    coordinates = [[NSMutableArray alloc]initWithCapacity:50];
    return self;
    
}

-(void)addLocation:(CLLocationCoordinate2D)coordinate atDate:(NSString*)atDate {
    //[coordinates addObject:coordinate];
    [dates addObject:atDate];
}


-(NSArray*)getDates {
    return dates;
}
-(NSArray*)getCoordinates {
    return coordinates;
}

-(NSString*)getStartTime {
    return dates.count ? [dates objectAtIndex:0] : nil;
}
-(NSString*)getEndTime { 
    return dates.count ? [dates objectAtIndex:dates.count-1] : nil;
}


@end
