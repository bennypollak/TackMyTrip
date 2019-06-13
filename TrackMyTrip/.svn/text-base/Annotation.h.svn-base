//
//  Annotation.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject<MKAnnotation>
-(Annotation*) initWithCoord:(CLLocationCoordinate2D)newCoordinate withTitle:(NSString*)newTitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;

- (MKAnnotationView *)annotationView;

@end
