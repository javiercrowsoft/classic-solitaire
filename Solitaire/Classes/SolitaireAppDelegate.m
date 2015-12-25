//
//  SolitaireAppDelegate.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SolitaireAppDelegate.h"
#import "CardBackDialog.h"
#import "OptionsDialog.h"

@implementation SolitaireAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch

	CGAffineTransform transform=CGAffineTransformIdentity;
	transform=CGAffineTransformRotate(transform, (90.0f*22.0f)/(180.0f*7.0f));
	transform=CGAffineTransformTranslate(transform, 80, 80);
	
    CardBackDialog *cardView = [[CardBackDialog alloc] initWithFrame:CGRectMake(0,0,480,320)];
	[window addSubview:cardView];
	[cardView setTransform:transform];	
	[cardView release];
	
	OptionsDialog *optionView = [[OptionsDialog alloc] initWithFrame:CGRectMake(0,0,480,320)];
	[window addSubview:optionView];
	[optionView setTransform:transform];
	[optionView release];
	
	[self loadDataFromDisk];
	if (m_mainView == nil) {
		m_mainView = [[Solitaire alloc] initWithFrame:CGRectMake(0,0,480,320)];
	}
	
	[window addSubview:m_mainView];
	[m_mainView setTransform:transform];	
	//[m_mainView release];
	
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self saveDataToDisk];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


- (NSString *) pathForDataFile 
{ NSFileManager *fileManager = [NSFileManager defaultManager]; 
	NSString *folder = @"~/Library/Solitaire/"; 
	folder = [folder stringByExpandingTildeInPath]; 
	if ([fileManager fileExistsAtPath: folder] == NO) { 
		[fileManager createDirectoryAtPath: folder attributes: nil]; 
	} 
	NSString *fileName = @"Solitaire.cdcsolitaire"; 
	return [folder stringByAppendingPathComponent: fileName]; 
} 

- (void) saveDataToDisk {
	if (m_mainView != nil) {
		NSString * path = [self pathForDataFile]; 
		NSMutableDictionary * rootObject; 
		rootObject = [NSMutableDictionary dictionary]; 
		[rootObject setValue: m_mainView forKey:@"mainView"]; 
		[NSKeyedArchiver archiveRootObject: rootObject  toFile: path]; 
		[m_mainView release];
	}
} 

- (void) loadDataFromDisk { 
	NSString * path = [self pathForDataFile]; 
	NSDictionary * rootObject; 
	rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 
	m_mainView = [rootObject valueForKey:@"mainView"]; 
} 

@end
