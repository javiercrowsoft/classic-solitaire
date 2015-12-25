//
//  Solitaire.h
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardStack.h"
#import "CardView.h"
#import "Constants.h"

@interface Solitaire : UIView <NSCoding> {
	
	int imageCardBack;
	
	CardStack *deckToDeal;
	UIImage *cardBack;
	UIImageView *dropPanel;
	UIImageView *ace0;
	UIImageView *ace1;
	UIImageView *ace2;
	UIImageView *ace3;
	UIImageView *stack0;
	UIImageView *stack1;
	UIImageView *stack2;
	UIImageView *stack3;
	UIImageView *stack4;
	UIImageView *stack5;
	UIImageView *stack6;
	UIToolbar *toolbar;
	
	UILabel *score; 
	UILabel *time; 
	
	NSMutableArray *cardsSpades;
	NSMutableArray *cardsDiamonds;
	NSMutableArray *cardsClubs;
	NSMutableArray *cardsHearts;
	
	NSTimer *repeatingTimer;
	
	// arrays to hold cards logic
	int m_stacks[7][5][19];		// Stack array, (stack) (suit, card value, x, y , flipped) (index)
	int m_deck[2][24];			// Deck array, (suit, card value) (index)
	int m_drop[4][24];			// Drop array, (suit, card value) (index)
	int m_drag[3][13];			// Drag array, (suit, card value, y) (index)
	int m_aceStacks[4][2][13];	// Ace drop array, (stack) (suit, card value) (index) 
	int m_stackLengths[7];		// Length of stack (one greater than last used index)
	int m_deckLength;			// Cards in dealing deck, -1 when flipping over deck
	int m_dropLength;			// Cards in dropping deck
	int m_dragLength;			// Cards in drag/drop action
	int m_aceStackLengths[4];	// Cards in each ace drop
	int m_hitCard;				// Card that the mouse was over when dragging, needed for multiple card drag
	BOOL m_dragging;			// True when drag/drop in process
	int m_cycleDeck;            // Number of times player has flipped the deck
	//int m_suit[3];              // Suits: spades=0, diamonds=1, clubs=2, hearts=3
	int m_aceLocation[2][4];	// X, Y and suit for ace drops
	int m_undoType;				// Undo type for switch and to get info from undo array
	int m_undo[7][3];			// Keeps undo information (type) (data)

	// Settings
	int m_scoring;				// Type of scoring (standar, vegas, vegas cumulative)
	BOOL m_drawOne;             // True when draggin one card not 3 
	BOOL m_timedGame;           // True if game is timed 

	int m_score;				// Score if keeping score
	int m_time;					// Time if keeping time
	
	int m_cardHeight;			// Card height and width
	int m_cardWidth;			//
	int m_xBigShift;			// For drop panel
	int m_yShift;				// 
	int m_xShift;				// 
	
	int m_small;                // Unflipped card Y shift
	int m_large;                // Flipped card Y shift
	
	int intNewShapeType;		// Last random number
	
	BOOL m_win;                 // False until user wins game
	
//	BOOL m_bInTouch;
}

-(void)updateCardBackImage:(int)index;
-(void)reloadDeckToDeal;
-(void)setTopCardInDeck:(CardView*)card;
-(BOOL)manageDropCard:(CardView*)card;
-(void)startDragCard:(CardView*)card;
-(void)managePickCard:(CardView*)card;
-(void)flipCard:(CardView*)card;
-(void)manageDoubleTap:(CardView*)card;
-(void)setStackZorder:(CardView*)card;
-(BOOL)cardIsInDeck:(CardView*)card;
-(void)setCardPositionInDeck:(CardView*)card;
-(void)deal;
-(void)setOrderInDeck;
-(CGPoint)getPositionInStack:(int)stack Suit:(int)suit CardValue:(int)cardValue;
-(void)updateScoringType:(int)scoring;
/*
-(void)startTouch;
-(BOOL)inTouch;
-(void)endTouch;
*/
@end
