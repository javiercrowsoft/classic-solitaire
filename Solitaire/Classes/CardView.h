//
//  CardView.h
//  Solitaire
//
//  Created by Javier Alvarez on 10/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface CardView : UIImageView {
	UIImage *cardImage;
	BOOL inDeck;
	BOOL inDropPanel;
	CGPoint m_location;
	BOOL flipped;
	int stack;
	int suit;
	int cardValue;
	BOOL m_bFirstCallToMoved;
	BOOL m_bOneTouch;
}

@property(nonatomic,retain) UIImage *cardImage;
@property(nonatomic) BOOL inDeck;
@property(nonatomic) BOOL inDropPanel;
@property(nonatomic) BOOL flipped;
@property(nonatomic) int stack;
@property(nonatomic) int suit;
@property(nonatomic) int cardValue;

-(void)resetCard;

@end
