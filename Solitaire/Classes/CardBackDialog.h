//
//  CardBackDialog.h
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Solitaire.h"


@interface CardBackDialog : UIView {
	
	int cardBack;

}

@property(nonatomic) int cardBack;

// TODO: functions to select cardback
-(BOOL)containsPoint:(CGPoint)point cardPosX:(int)x cardPosY:(int)y;

-(void)hideView;

@end
