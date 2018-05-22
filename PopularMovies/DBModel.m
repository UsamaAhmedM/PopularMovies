//
//  DBModel.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "DBModel.h"
#import <sqlite3.h>
#import "Movie.h"
@implementation DBModel
{
    NSString *docsDir,*databasePath;
    NSArray *dirPaths;
    char *dbpath;
    sqlite3 *moviesDB;
}
-(id)init
{
    self= [super init];
    if (self) {
        
        [self reloadDatabasePath];
        
        
        if (sqlite3_open(dbpath, &moviesDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt=
            "CREATE TABLE IF NOT EXISTS MOVIES (ID INTEGER PRIMARY KEY ,VOTE TEXT, TITLE TEXT, POSTER TEXT, ORIGINAL_TITLE TEXT, OVERVIEW TEXT, RELEASE_DATE TEXT,FAVOURITE INTEGER)";
            
            if (sqlite3_exec(moviesDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                printf("%s",errMsg);
                return @"Couldn't Create DB";
            }
            sqlite3_close(moviesDB);
        } else {
            NSLog(@"Couldn't Open/ Create DB");
            return @"Couldn't Open/ Create DB;";
        }
    }
    
    NSLog(@" Open/ Create DB successfully");
    return self;
}

-(BOOL)insertMovies:(NSArray*)movies{
    BOOL res=YES;
    for (Movie *mv in movies) {
        res=[self insertMovie:mv];
    }
    return res;
}
 
 
 -(BOOL)insertMovie:(Movie*)movie{
 
 sqlite3_stmt  *statement;
 BOOL result=NO;
     
     [self reloadDatabasePath];
 if (sqlite3_open(dbpath, &moviesDB) == SQLITE_OK)
 {
     NSString *insertSQL ;
     if(movie.fav!=nil)
     {
  insertSQL =
 [NSString stringWithFormat:
@"INSERT OR REPLACE INTO MOVIES (ID,VOTE,TITLE,POSTER,ORIGINAL_TITLE,OVERVIEW,RELEASE_DATE,FAVOURITE) VALUES (%@,%@,  \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",%@)",
  movie.movieID,movie.voteAverage,movie.title,movie.posterPath,movie.originalTitle,movie.overview,movie.releaseDate, movie.fav];
     }else{
          insertSQL =
         [NSString stringWithFormat:
          @"INSERT OR REPLACE INTO MOVIES (ID,VOTE,TITLE,POSTER,ORIGINAL_TITLE,OVERVIEW,RELEASE_DATE,FAVOURITE) VALUES (%@,%@,  \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",%d)",
          movie.movieID,movie.voteAverage,movie.title,movie.posterPath,movie.originalTitle,movie.overview,movie.releaseDate, 0];
     }
         
 const char *insert_stmt = [insertSQL UTF8String];
 sqlite3_prepare_v2(moviesDB, insert_stmt,
 -1, &statement, NULL);
 if (sqlite3_step(statement) == SQLITE_DONE)
 {
 NSLog(@"Inserted successfully");
 result=YES;
 }
 NSLog(@"ERROR %s",sqlite3_errmsg(moviesDB));
 sqlite3_finalize(statement);
 sqlite3_close(moviesDB);
 }
 
 NSLog(@"ERROR %s",sqlite3_errmsg(moviesDB));
 return result;
 
 
 }

-(NSArray<Movie>*) getStoredMovies{
        
        sqlite3_stmt    *statement;
        NSMutableArray<Movie> *moviesArray;
        [self reloadDatabasePath];
        if (sqlite3_open(dbpath, &moviesDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:
                                  @"SELECT ID, VOTE, TITLE, POSTER, ORIGINAL_TITLE, OVERVIEW, RELEASE_DATE, FAVOURITE FROM MOVIES "];
            
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(moviesDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                moviesArray=[NSMutableArray<Movie> new];
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSNumber *movieID=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 0)];
                    NSNumber *voteAverage=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 1)];
                    NSString *title=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 2)];
                    NSString *posterPath=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 3)];
                    NSString *originalTitle=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 4)];
                    NSString *overview=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 5)];
                     NSString *releaseDate=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 6)];
                    NSNumber *fav=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 7)];
                    
                    Movie *movie=[Movie new];
                    movie.movieID=movieID;
                    movie.voteAverage=voteAverage;
                    movie.title=title;
                    movie.posterPath=posterPath;
                    movie.originalTitle=originalTitle;
                    movie.overview=overview;
                    movie.releaseDate=releaseDate;
                    movie.fav=fav;
                    [moviesArray addObject:movie];
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(moviesDB);
        }
        return moviesArray;
    }

-(NSArray<Movie>*) getStoredFavouriteMovies
{
sqlite3_stmt    *statement;
NSMutableArray<Movie> *moviesArray;
[self reloadDatabasePath];
if (sqlite3_open(dbpath, &moviesDB) == SQLITE_OK)
{
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT ID, VOTE, TITLE, POSTER, ORIGINAL_TITLE, OVERVIEW, RELEASE_DATE, FAVOURITE FROM MOVIES WHERE FAVOURITE > 0"];
    
    const char *query_stmt = [querySQL UTF8String];
    if (sqlite3_prepare_v2(moviesDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        moviesArray=[NSMutableArray<Movie> new];
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSNumber *movieID=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 0)];
            NSNumber *voteAverage=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 1)];
            NSString *title=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 2)];
            NSString *posterPath=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 3)];
            NSString *originalTitle=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 4)];
            NSString *overview=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 5)];
            NSString *releaseDate=[[NSString alloc]                                                             initWithUTF8String:                                                             (const char *) sqlite3_column_text(                                                                                                                                                                                                                                                             statement, 6)];
            NSNumber *fav=[NSNumber numberWithInt:(int) sqlite3_column_int(                                                                                                                                                                                                                                                             statement, 7)];
            
            Movie *movie=[Movie new];
            movie.movieID=movieID;
            movie.voteAverage=voteAverage;
            movie.title=title;
            movie.posterPath=posterPath;
            movie.originalTitle=originalTitle;
            movie.overview=overview;
            movie.releaseDate=releaseDate;
            movie.fav=fav;
            [moviesArray addObject:movie];
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(moviesDB);
}
return moviesArray;
}
-(void) reloadDatabasePath{
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc]
                    initWithString: [docsDir stringByAppendingPathComponent:
                                     @"movies.db"]];
    dbpath = [databasePath UTF8String];
}
   
@end
