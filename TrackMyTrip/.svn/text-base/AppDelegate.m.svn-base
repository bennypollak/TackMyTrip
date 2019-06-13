//
//  AppDelegate.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocHistoryDB.h"

@implementation AppDelegate

@synthesize window = _window;

@synthesize dbFilePath;

NSString *DATABASE_RESOURCE_NAME = @"trackmytrip";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"trackmytrip.db";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	if (! [self initializeDb]) {
		// TODO: alert the user!
		NSLog (@"couldn't init db");
		return NO;
	}	
//    NSURL *url = nil;
//    if ((url=[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey]) != nil) {
//        NSLog(@"Launched with url: %@", [url path]);
//        [[LocHistoryDB sharedInstance]loadTripFromURL:url];        
//    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    NSLog(@"activated with url: %@", [url path]);
    [[LocHistoryDB sharedInstance]insertTripFromURL:url];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    NSString *itemName = [notif.userInfo objectForKey:@"ToDoItemKey"];
    NSLog(@"Got notification: %@", itemName);
    //[viewController displayItem:itemName];  // custom method
    //app.applicationIconBadgeNumber = notif.applicationIconBadgeNumber-1;
}



#pragma mark - DB init
- (BOOL) initializeDb {
	NSLog (@"initializeDB");
	// look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
	//START:code.DatabaseShoppingList.findDocumentsDirectory
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	dbFilePath = [documentFolderPath stringByAppendingPathComponent:
				  DATABASE_FILE_NAME];
    NSLog(@"%@", dbFilePath);
	//END:code.DatabaseShoppingList.findDocumentsDirectory
	//[dbFilePath retain];
	//START:code.DatabaseShoppingList.copyDatabaseFileToDocuments
	if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
		// didn't find db, need to copy
		NSString *backupDbPath = [[NSBundle mainBundle]
								  pathForResource:DATABASE_RESOURCE_NAME
								  ofType:DATABASE_RESOURCE_TYPE];
		if (backupDbPath == nil) {
			// couldn't find backup db to copy, bail
			return NO;
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager]
								   copyItemAtPath:backupDbPath
								   toPath:dbFilePath
								   error:nil];
			if (! copiedBackupDb) {
				// copying backup db failed, bail
				return NO;
			}
		}
	}
	NSLog (@"bottom of initializeDb");
	return YES;
}



@end
