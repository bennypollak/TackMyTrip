//
//  MapViewController.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import "LocManager.h"

@implementation MapViewController
@synthesize mapView;
@synthesize ident;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ident = [[LocManager sharedInstance] currentIdent];
    NSArray *locations = [[LocHistoryDB sharedInstance] getLocationsForIdent:ident];

    [self loadRoute:locations];
 
 // add the overlay to the map
     if (nil != routeLine) {
         [mapView addOverlay:routeLine];
     }
 
 // zoom in on the route. 
 [self zoomInOnRoute];

}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailMap"]) {
        DetailViewController *detailView = [segue destinationViewController];
        detailView.ident = ident;
        //UITableViewCell *cell = sender;
//        [mapView setIdent:selectedCell.textLabel.text];
        //        [[segue destinationViewController] setDelegate:self];
        
    }
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loadRoute:(NSArray*)locations {
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
    
    int count = [locations count];
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * count);
    Annotation *startingAnnot, *endAnnot;
    for (int idx = 0; idx < count; idx++) {
        CLLocation *loc = [locations objectAtIndex:idx];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        pointArr[idx] = point;
		// if it is the first point, just use them, since we have nothing to compare to yet. 
		if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
            startingAnnot = [[Annotation alloc]initWithCoord:coordinate withTitle:@"Start"];
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}
        if (idx == count-1) {
            endAnnot = [[Annotation alloc]initWithCoord:coordinate withTitle:@"End"];
        }
    }
    [mapView addAnnotation:startingAnnot];
    [mapView addAnnotation:endAnnot];
    routeLine = [MKPolyline polylineWithPoints:pointArr count:count];
    
    [mapView addOverlay:routeLine];
	_routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
    free(pointArr);
}

static double latitudes[] = {
    40.732491, 40.73251, 40.732522, 40.732521, 40.732609, 40.732703, 40.732729,
    40.732779, 40.732801, 40.732799, 40.732938, 40.732954, 40.732989, 40.733002,
    40.733001, 40.732982, 40.732963, 40.733072, 40.733151, 40.733217, 40.733284,
    40.733344, 40.733384, 40.733442, 40.733479, 40.733514, 40.733562, 40.733628,
    40.733694, 40.733731, 40.733755, 40.733777, 40.733853, 40.73392, 40.733975,
    40.734037, 40.734103, 40.734112, 40.734173, 40.734208, 40.734299, 40.734299,
    40.734239, 40.734177, 40.734324, 40.73428, 40.734351, 40.73426, 40.734252,
    40.734567, 40.734519, 40.734488, 40.734333, 40.73441, 40.73434, 40.734277,
    40.734305, 40.734248, 40.734428, 40.734265, 40.734341, 40.734394, 40.734274,
    40.734328, 40.734249, 40.734241, 40.734316, 40.734402, 40.734319, 40.734298,
    40.734324, 40.734281, 40.734283, 40.734415, 40.734348, 40.73447, 40.734537,
    40.734499, 40.734378, 40.73449, 40.734583, 40.73475, 40.73475, 40.735173, 
    40.73441, 40.734339, 40.734334, 40.734409, 40.734406, 40.734331, 40.73426,
    40.734172, 40.734191, 40.73421, 40.734193, 40.734148, 40.73412, 40.734086, 
    40.734012, 40.733972, 40.733905, 40.73386, 40.733806, 40.733769, 40.733704,
    40.733651, 40.73363, 40.733635, 40.733574, 40.733515, 40.733461, 40.733417,
    40.733361, 40.733317, 40.73327, 40.73324, 40.733228, 40.733219, 40.733166, 
    40.733083, 40.733014, 40.732956, 40.732865, 40.732784, 40.73272, 40.732736,
    40.732736, 40.732686, 40.732618, 40.732564, 40.732518, 40.732465, 40.732389,
    40.732312, 40.732061, 40.732129, 40.731971, 40.732022, 40.732168, 40.731923, 
    40.732025, 40.732016, 40.731989, 40.731925,};

static double longitudes[] = {
    -73.99488, -73.995011, -73.995132, -73.995282, -73.995371, -73.995405, -73.995529,
    -73.995641, -73.995786, -73.995925, -73.995908, -73.99603, -73.996155,
    -73.996284, -73.996319, -73.996435, -73.996563, -73.996603, -73.996672,
    -73.99679, -73.996871, -73.996987, -73.997094, -73.997192, -73.997334,
    -73.997467, -73.997583, -73.997684, -73.997795, -73.997909, -73.998036,
    -73.998166, -73.998236, -73.998334, -73.998455, -73.998548, -73.998643,
    -73.998766, -73.998882, -73.998998, -73.998939, -73.998939, -73.999133,
    -73.999322, -73.999118, -73.999232, -73.99912, -73.999232, -73.999234,
    -73.998694, -73.998726, -73.998899, -73.999223, -73.999109, -73.999219,
    -73.999128, -73.99926, -73.999216, -73.999105, -73.999157, -73.998955,
    -73.998773, -73.998704, -73.998944, -73.999101, -73.999314, -73.998978,
    -73.998943, -73.998973, -73.999097, -73.998825, -73.999218, -73.999082,
    -73.999165, -73.999177, -73.999127, -73.999243, -73.999251, -73.999207,
    -73.999296, -73.999273, -73.999215, -73.999215, -73.999971, -73.999094,
    -73.99918, -73.999177, -73.999094, -73.999098, -73.999166, -73.999275,
    -73.999369, -73.999232, -73.999041, -73.998909, -73.998764, -73.998648,
    -73.998537, -73.998452, -73.998334, -73.998228, -73.998125, -73.998025,
    -73.997908, -73.997805, -73.997675, -73.997542, -73.997418, -73.997325,
    -73.99723, -73.997119, -73.997012, -73.996919, -73.996814, -73.996712,
    -73.996583, -73.996464, -73.996342, -73.996229, -73.996125, -73.996046,
    -73.995949, -73.995881, -73.995828, -73.995744, -73.995607, -73.995469,
    -73.995361, -73.995275, -73.995174, -73.995071, -73.99496, -73.994876,
    -73.994811, -73.995095, -73.995275, -73.995026, -73.994993, -73.994975,
    -73.995085, -73.995046, -73.995089, -73.99505, -73.994822,};


- (IBAction)test:(id)sender {
    
    [self loadRoute];
    routeLineView = nil;
    // add the overlay to the map
    if (nil != routeLine) {
        [mapView addOverlay:routeLine];
    }
    
    // zoom in on the route. 
    [self zoomInOnRoute];
    
}
-(void)loadRoute {
    //    CLLocationCoordinate2D center;
    //    center.latitude = 40.732491;
    //    center.longitude = -73.994880;
    //    [mapView setCenterCoordinate:center animated:YES];
    //    MKCoordinateRegion region;
    //    MKCoordinateSpan span;
    //    span.latitudeDelta = 0.004;
    //    span.longitudeDelta = 0.006;
    //    region.span = span;
    //    region.center = center;
    //    [mapView setRegion:region];
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
    
    int count = sizeof(longitudes)/sizeof(double);
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * count);
    Annotation *startingAnnot;
    for (int idx = 0; idx < count; idx++) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitudes[idx], longitudes[idx]);
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        pointArr[idx] = point;
		// if it is the first point, just use them, since we have nothing to compare to yet. 
		if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}
    }
    [mapView addAnnotation:startingAnnot];
    
    
    routeLine = [MKPolyline polylineWithPoints:pointArr count:count];
    [mapView addOverlay:routeLine];
	_routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
    
    free(pointArr);
}
-(void) zoomInOnRoute
{
	[self.mapView setVisibleMapRect:_routeRect];
}
#pragma mark MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    
    if(overlay == routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == routeLineView)
        {
            routeLineView = [[MKPolylineView alloc] initWithPolyline:routeLine];
            routeLineView.fillColor = [UIColor redColor];
            routeLineView.strokeColor = [UIColor redColor];
            routeLineView.lineWidth = 3;
        }
        
        overlayView = routeLineView;
        
    }
    
    return overlayView;
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *view = [((Annotation*)annotation) annotationView];
    
    return view;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    //NSLog(@"Dragging");
    Annotation *annot = annotationView.annotation;
    if (newState == MKAnnotationViewDragStateEnding) {
        annot.subtitle = @"dragged";
    }
}

@end
