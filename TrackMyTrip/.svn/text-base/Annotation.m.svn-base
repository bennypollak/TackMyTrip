//
//  Annotation.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation {
    CLLocationCoordinate2D coord;
    MKAnnotationView *_annotationView;
}
@synthesize title, subtitle;

-(Annotation*) initWithCoord:(CLLocationCoordinate2D)newCoordinate withTitle:(NSString*)newTitle {
    self = [super init];
    if(nil != self) {
    }
    coord = newCoordinate;
    title = newTitle;
    subtitle = @"sub...";
    return self;

}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate 
{
    coord = newCoordinate;
}
- (CLLocationCoordinate2D) coordinate
{
    return coord;
}

- (MKAnnotationView *)annotationView
{
    if (!_annotationView) {
        id <MKAnnotation> annotation = self;
        if (annotation) {
            MKPinAnnotationView *pin =
            [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
            pin.canShowCallout = YES;
            pin.animatesDrop = YES;
            pin.draggable = YES;
            pin.pinColor = MKPinAnnotationColorRed;
            _annotationView = pin;
        }
    }
    return _annotationView;
}

@end
