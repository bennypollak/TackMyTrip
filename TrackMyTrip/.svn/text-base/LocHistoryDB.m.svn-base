//
//  LocHistoryDB.m
//  BinClock
//
//  Created by Benny Pollak on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocHistoryDB.h"
#import "AppDelegate.h"

@implementation LocHistoryDB

static LocHistoryDB *instance;

- (id)init {
    self = [super init];
    if(nil != self) {
    }
    instance = self;
    return self;
}

+ (LocHistoryDB*)sharedInstance {
    if (instance  == nil) {
        instance = [[LocHistoryDB alloc]init];
    }
    return instance;
}



- (sqlite3 *)prepareStmt:(sqlite3_stmt**)dbpsp withSQL:(NSString*)sqlNS
{
	sqlite3 *db;
	AppDelegate *appDelegate = (AppDelegate*)
	[UIApplication sharedApplication].delegate;
	const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
	int dbrc; // database return code
	dbrc = sqlite3_open (dbFilePathUTF8, &db);
	if (dbrc) {
		NSLog (@"couldn't open db:");
		return nil;
	}
	const char *sql = [sqlNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, sql, -1, dbpsp, NULL);
	return db;
}

- (void) clearForIdent:(NSString*)ident {
    NSString *sql = [NSString stringWithFormat:@"delete from \"lochist\" where ident='%@'", ident];
    
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sql];
    NSLog(@"%@", sql);
	
	sqlite3_step (dbps);
	// done with the db.  finalize the statement and close
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}

- (NSArray*)getLocationsForIdent:(NSString*)ident {
    //	NSString *sqlNS = @"select strftime(\"%Y-%m-%d\", attime),latitude,longitude from lochist order by attime";
	NSString *sqlNS = [NSString stringWithFormat:@"select attime,latitude,longitude from lochist where ident='%@' order by attime", ident];
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sqlNS];
	
	NSMutableArray* locs = [[NSMutableArray alloc] initWithCapacity: 50]; // arbitrary capacity
	int dbrc = 0;
	// repeatedly execute the prepared statement until we're out of results
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		//NSDate *attime = nil;//(char*) sqlite3_column_text (dbps, 0); 
		double latitude = sqlite3_column_double(dbps, 1);
		double longitude = sqlite3_column_double(dbps, 2);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		[locs addObject:loc];
	}
	sqlite3_close(db);
	return locs;
}
- (NSMutableArray*)getLocationsAsText {
    //	NSString *sqlNS = @"select strftime(\"%Y-%m-%d\", attime),latitude,longitude from lochist order by attime";
	NSString *sqlNS = @"select attime,latitude,longitude from lochist order by attime";
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sqlNS];
	
	NSMutableArray* ufs = [[NSMutableArray alloc] initWithCapacity: 50]; // arbitrary capacity
	int dbrc = 0;
	// repeatedly execute the prepared statement until we're out of results
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		char *attime = (char*) sqlite3_column_text (dbps, 0); 
		double latitude = sqlite3_column_double(dbps, 1);
		double longitude = sqlite3_column_double(dbps, 2);
        NSString *loc = [NSString stringWithFormat:@"%s - %f %f", attime, latitude, longitude];
		[ufs addObject:loc];
	}
	sqlite3_close(db);
	return ufs;
}


- (NSMutableArray*)getAllIdents {
    //	NSString *sqlNS = @"select strftime(\"%Y-%m-%d\", attime),latitude,longitude from lochist order by attime";
	NSString *sql = [NSString stringWithFormat:@"select distinct ident from lochist order by attime"];
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sql];
	
    NSLog(@"%@", sql);
	NSMutableArray* locs = [[NSMutableArray alloc] initWithCapacity: 50]; // arbitrary capacity
	int dbrc = 0;
	// repeatedly execute the prepared statement until we're out of results
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		NSString *ident = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(dbps, 0)];
		[locs addObject:ident];
	}
	sqlite3_close(db);
    NSLog(@"found %d", locs.count);

	return locs;
}
-(NSString*)getNextIdentFor:(NSString*)counterId {
    NSString *ident;
	NSString *sqlNS = [NSString stringWithFormat:@"select count from counter where id='%@'", counterId];
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sqlNS];
	int dbrc = 0;
    int count = 0;
	// repeatedly execute the prepared statement until we're out of results
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		count = sqlite3_column_int(dbps, 0);
        ident = [NSString stringWithFormat:@"trip%d", count];
	}
	sqlite3_close(db);
    
    sqlNS = @"update counter set count=count+1";
    db = [self prepareStmt:&dbps withSQL:sqlNS];

	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		count = sqlite3_column_int(dbps, 0);
        ident = [NSString stringWithFormat:@"trip%d", count];
	}
	sqlite3_close(db);
    return ident;
    
}

- (NSArray*)getLocationsAsCSVForIdent:(NSString*)ident localized:(BOOL)localized{
	NSString *sqlNS = [NSString stringWithFormat:@"select strftime('%%Y-%%m-%%d %%H:%%M:%%S',attime%@),latitude,longitude from lochist where ident='%@' order by attime", 
                       localized?@", 'localtime'":@"",
                       ident];
    NSLog(@"%@", sqlNS);
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sqlNS];
	
	NSMutableArray* ufs = [[NSMutableArray alloc] initWithCapacity: 50]; // arbitrary capacity
	int dbrc = 0;
	// repeatedly execute the prepared statement until we're out of results
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		char *attime = (char*) sqlite3_column_text (dbps, 0); 
		double latitude = sqlite3_column_double(dbps, 1);
		double longitude = sqlite3_column_double(dbps, 2);
        NSString *loc = [NSString stringWithFormat:@"%s,%f,%f", attime, latitude, longitude];
		[ufs addObject:loc];
	}
	sqlite3_close(db);
	return ufs;
}




-(BOOL)insertTripFromURL:(NSURL*)url {
    NSFileHandle* aHandle = [NSFileHandle fileHandleForReadingFromURL:url error:nil];
    NSData* fileContents = nil;
    NSLog(@"loading path");
    if (!aHandle) return NO;
    
    fileContents = [aHandle readDataToEndOfFile];
    NSString *str = [NSString stringWithUTF8String:[fileContents bytes]];

    //NSLog(@"loaded str: %@", str);
    [self insertTripFromString:str forIdent:nil];
    return YES;
}
// insert into "lochist" (ident, attime, latitude, longitude) values ("_s1", "2011-12-26 00:39:10", 40.731827, -73.994621)

-(BOOL)insertTripFromString:(NSString*)str forIdent:(NSString*)ident
{
    NSArray *lines = [str componentsSeparatedByString:@"\n"];
    if (lines.count == 0) {
        return NO;
    }
    NSString *line;
    NSArray *parts;
    if (ident == nil) {
        ident = [NSString stringWithFormat:@"_%@", [self getNextIdentFor:@"trip"]];
    }
    
    NSEnumerator *enumerator = [lines objectEnumerator];
    while ((line = [enumerator nextObject])) {
        //NSLog(@"--> %@", line);
        parts = [line componentsSeparatedByString:@","];

        // done with the db.  finalize the statement and close
        if (parts.count == 3) {
            // insert into "lochist" (ident, attime, latitude, longitude)                                   values ("_s1", "2011-12-26 00:39:10", 40.731827, -73.994621)
            NSString *sql = [NSString stringWithFormat:
                                       @"insert into 'lochist'\
                                       (ident, attime, latitude, longitude)\
                                       values ('%@', '%@', %@, %@)",
                                       ident, [parts objectAtIndex:0], [parts objectAtIndex:1], [parts objectAtIndex:2]
                                       ];
            sqlite3_stmt *dbps; // database prepared statement
            sqlite3 *db = [self prepareStmt:&dbps withSQL:sql];
            
            sqlite3_step (dbps);
            //NSLog(@"%d: %@", dbrc, sql);
        // done with the db.  finalize the statement and close
            sqlite3_finalize (dbps);
            sqlite3_close(db);

        
        }

    }

    return YES;
}

- (void) insertLoation:(CLLocation*)location forIdent:(NSString*)ident{
	NSDate *atdate = location.timestamp;
    double longitude = location.coordinate.longitude;
    double latitude = location.coordinate.latitude;
    
    NSString *insertStatementNS = [NSString stringWithFormat:
								   @"insert into \"lochist\"\
								   (ident, attime, latitude, longitude)\
								   values (\"%@\", \"%@\", %f, %f)",
								   ident, atdate, latitude, longitude
								   ];
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:insertStatementNS];
    NSLog(@"%@", insertStatementNS);
	
	sqlite3_step (dbps);
	// done with the db.  finalize the statement and close
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}

- (void) clearAll {
    NSString *sql = @"delete from \"lochist\"";
    
	sqlite3_stmt *dbps; // database prepared statement
	sqlite3 *db = [self prepareStmt:&dbps withSQL:sql];
    NSLog(@"%@", sql);
	
	sqlite3_step (dbps);
	// done with the db.  finalize the statement and close
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}


@end
