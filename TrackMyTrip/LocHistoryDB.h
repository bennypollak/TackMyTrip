//
//  LocHistoryDB.h
//  BinClock
//
//  Created by Benny Pollak on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import <CoreLocation/CoreLocation.h>

@interface LocHistoryDB : NSObject
+ (LocHistoryDB*)sharedInstance;
- (id) init;

- (sqlite3*)prepareStmt:(sqlite3_stmt**)dbpsp withSQL:(NSString*)sqlNS;

- (void)clearAll;
- (void)clearForIdent:(NSString*)ident;

- (void)insertLoation:(CLLocation*)location forIdent:(NSString*)ident;
- (BOOL)insertTripFromURL:(NSURL*)url;
- (BOOL)insertTripFromString:(NSString*)str forIdent:(NSString*)ident;

- (NSMutableArray*)getLocationsAsText;
- (NSArray*)getLocationsAsCSVForIdent:(NSString*)ident localized:(BOOL)localized;
- (NSMutableArray*)getAllIdents;
- (NSArray*)getLocationsForIdent:(NSString*)ident;
- (NSString*)getNextIdentFor:(NSString*)counterId;


@end
