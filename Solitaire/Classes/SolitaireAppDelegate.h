//
//  SolitaireAppDelegate.h
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Solitaire.h"

@interface SolitaireAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	Solitaire *m_mainView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSString *) pathForDataFile; 
- (void) saveDataToDisk; 
- (void) loadDataFromDisk; 

@end

