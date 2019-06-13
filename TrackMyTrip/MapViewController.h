//
//  MapViewController.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    MKPolyline *routeLine;
    MKPolylineView *routeLineView;
    MKMapRect _routeRect;
}
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)test:(id)sender;
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay;
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;

-(void) loadRoute;
-(void)loadRoute:(NSArray*)locations;
@property (retain) NSString *ident;

// use the computed _routeRect to zoom in on the route. 
-(void) zoomInOnRoute;

@end
