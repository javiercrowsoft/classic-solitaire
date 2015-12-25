//
//  Debug.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Debug.h"

void debugShow(NSString* message) {

	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Solitaire" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];	
}