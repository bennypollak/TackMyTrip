//
//  AppDelegate.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
- (BOOL) initializeDb;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSString *dbFilePath;

@end
