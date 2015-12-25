//
//  Solitaire.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Solitaire.h"
#import "Debug.h"


@implementation Solitaire

+ (UILabel*)labelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    
	label.textAlignment = UITextAlignmentLeft;
    label.text = title;
    label.font = [UIFont systemFontOfSize:17.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
	
    return label;
}

- (void)updateStatus {
	score.text = [NSString stringWithFormat:@"%d", m_score];
}

- (int)getNextRandom {
	int randomNumber;
	do {
		randomNumber = arc4random() % 23;
	} while (intNewShapeType == randomNumber);
	return intNewShapeType;
}

- (int)getNextRandomMax:(int)maximum {
	int randomNumber;
	do {
		randomNumber = arc4random() % maximum;
	} while (randomNumber < 0);
	return randomNumber;
}

- (void) shuffle {
	int temp[2][24];
	int templenght = m_deckLength;
	int index;
	int i;
	
	// Copy data to temp
	for (i=0; i<m_deckLength; i++) {
		temp[0][i] = m_deck[0][i];
		temp[1][i] = m_deck[1][i];
		
		// TODO: delete debug
#if DEBUG
		if (m_deck[0][i]<0 || m_deck[0][i]>3) {
			debugShow(@"index out of range in m_deck function shufle");		
		}
		if (m_deck[1][i]<0 || m_deck[1][i]>13) {
			debugShow(@"index out of range in m_deck function shufle");
		}
#endif
		// TODO: delete debug fin
	}
	
	intNewShapeType = -1;
	
	for (i=0; i<m_deckLength; i++) {
		
		// Get random index
		index = [self getNextRandomMax:templenght];
		
		// TODO: delete debug
#if DEBUG
		if (index < 0 || index > 23) {
			debugShow(@"index out of range in m_deck function shufle");
		}
#endif
		// TODO: delete debug fin
		
		// Copy data at that index to deck
		m_deck[0][i] = temp[0][index];
		m_deck[1][i] = temp[1][index];
		
		// Get last set in temp and move to index
		temp[0][index] = temp[0][templenght-1];
		temp[1][index] = temp[1][templenght-1];
		
		// Shorten temp
		templenght--;
	}
}

- (CGPoint)nextCard:(int[4][13])vcards {
	
	// Get next random unused card in deck
	int suit;
	int cardValue;
	
	do {
		
		// Randomly select m_winParabola suit and card value
		suit = [self getNextRandomMax:4];
		cardValue = [self getNextRandomMax:13];
		
		// Check to see if the card is already used
		if (vcards[suit][cardValue] == -1 /*0*/) {
			// Not used, so we are done
			break;
		}
	} while (TRUE);
	
	vcards[suit][cardValue] = 1; // Set used flag
	
	CGPoint rtn = CGPointMake(suit, cardValue);
	return rtn;
	
}

- (void)setCardStack:(int)stack Suit:(int)suit CardValue:(int)cardValue X:(int)x Y:(int)y Flipped:(int)flipped Index:(int)index {
	m_stacks[stack][0][index] = suit;
	m_stacks[stack][1][index] = cardValue;
	m_stacks[stack][2][index] = x;
	m_stacks[stack][3][index] = y;
	m_stacks[stack][4][index] = flipped;
}

- (void)setCardBackImage:(int)index {
	
	switch (index) {
		case 1:
			cardBack = [UIImage imageNamed:@"cardback1c.png"];
			break;
		case 2:
			cardBack = [UIImage imageNamed:@"cardback2c.png"];
			break;
		case 3:
			cardBack = [UIImage imageNamed:@"cardback3c.png"];
			break;
		case 4:
			cardBack = [UIImage imageNamed:@"cardback4c.png"];
			break;
		case 5:
			cardBack = [UIImage imageNamed:@"cardback5c.png"];
			break;
		case 6:
			cardBack = [UIImage imageNamed:@"cardback6c.png"];
			break;
		case 7:
			cardBack = [UIImage imageNamed:@"cardback7c.png"];
			break;
		case 8:
			cardBack = [UIImage imageNamed:@"cardback8c.png"];
			break;
		case 9:
			cardBack = [UIImage imageNamed:@"cardback9c.png"];
			break;
		case 10:
			cardBack = [UIImage imageNamed:@"cardback10c.png"];
			break;
		case 11:
			cardBack = [UIImage imageNamed:@"cardback11c.png"];
			break;
		case 12:
			cardBack = [UIImage imageNamed:@"cardback12c.png"];
			break;
		default:
			break;
	}
	
}

- (void)initAceStack {
	
	ace0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	ace0.frame = CGRectMake(200, DROP_PANEL_TOP, ace0.frame.size.width, ace0.frame.size.height);
	[self addSubview:ace0];
	
	ace1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	ace1.frame = CGRectMake(265, DROP_PANEL_TOP, ace1.frame.size.width, ace1.frame.size.height);
	[self addSubview:ace1];
	
	ace2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	ace2.frame = CGRectMake(330, DROP_PANEL_TOP, ace2.frame.size.width, ace2.frame.size.height);
	[self addSubview:ace2];
	
	ace3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	ace3.frame = CGRectMake(395, DROP_PANEL_TOP, ace3.frame.size.width, ace3.frame.size.height);
	[self addSubview:ace3];	
	
}

- (void)createCardHolders {
	
	imageCardBack = 1;
	cardBack = [UIImage imageNamed:@"cardback1c.png"];
	
	deckToDeal = [[CardStack alloc] initWithImage:[UIImage imageNamed:@"cardEmptyc.png"]];
	deckToDeal.frame = CGRectMake(5, DROP_PANEL_TOP, deckToDeal.frame.size.width, deckToDeal.frame.size.height);
	deckToDeal.isDeckToDeal = YES;
	[self addSubview:deckToDeal];

	dropPanel = [[CardStack alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	dropPanel.frame = CGRectMake(DROP_PANEL_LEFT, DROP_PANEL_TOP, dropPanel.frame.size.width, dropPanel.frame.size.height);
	[self addSubview:dropPanel];
	
	[self initAceStack];
	
	stack0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack0.frame = CGRectMake(5, STACK_PANEL_TOP, stack0.frame.size.width, stack0.frame.size.height);
	[self addSubview:stack0];
	
	stack1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack1.frame = CGRectMake(70, STACK_PANEL_TOP, stack1.frame.size.width, stack1.frame.size.height);
	[self addSubview:stack1];
	
	stack2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack2.frame = CGRectMake(135, STACK_PANEL_TOP, stack2.frame.size.width, stack2.frame.size.height);
	[self addSubview:stack2];
	
	stack3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack3.frame = CGRectMake(200, STACK_PANEL_TOP, stack3.frame.size.width, stack3.frame.size.height);
	[self addSubview:stack3];
	
	stack4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack4.frame = CGRectMake(265, STACK_PANEL_TOP, stack4.frame.size.width, stack4.frame.size.height);
	[self addSubview:stack4];
	
	stack5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack5.frame = CGRectMake(330, STACK_PANEL_TOP, stack5.frame.size.width, stack5.frame.size.height);
	[self addSubview:stack5];
	
	stack6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardSlotE.png"]];
	stack6.frame = CGRectMake(395, STACK_PANEL_TOP, stack6.frame.size.width, stack6.frame.size.height);
	[self addSubview:stack6];
	
}

- (void)createToolbar {
	// Table top
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
	[self addSubview:imageView];
	[imageView release];
	
	// i button
	UIView *view;
	view = [[UIView alloc] initWithFrame:CGRectMake(0,280,480,40)];
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	infoButton.frame = CGRectMake(440, 0, 44, 44);
	[infoButton addTarget:self action:@selector(showToolbar) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:infoButton];
	[self addSubview:view];
	[view release];
		
	//Toolbar
	toolbar = [[UIToolbar alloc] init];
	[toolbar sizeToFit];
	CGFloat toolbarHeight = [toolbar frame].size.height;
	CGRect rootViewBounds = self.bounds;
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	[toolbar setFrame:rectArea];
	
	UIBarButtonItem *dealButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Deal" style:UIBarButtonItemStyleBordered target:self action:@selector(deal)];

	UIBarButtonItem *deckButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Deck" style:UIBarButtonItemStyleBordered target:self action:@selector(configDeck)];

	UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Options" style:UIBarButtonItemStyleBordered target:self action:@selector(editOptions)];
	
	[toolbar setItems:[NSArray arrayWithObjects:dealButton,deckButton,optionsButton,nil]];
	
	toolbar.barStyle = UIBarStyleBlack;
	toolbar.tintColor = [UIColor blackColor]; 
	toolbar.translucent = YES;
	
	toolbar.hidden = NO;
	
	//Add the toolbar as a subview to the navigation controller.
	[self addSubview:toolbar];

	CGRect frame = CGRectMake(210, 290, 200, 30);
	[self addSubview:[Solitaire labelWithFrame:frame title:@"Score"]];
	
	frame = CGRectMake(270, 290, 200, 30);
	score = [Solitaire labelWithFrame:frame title:@"0"];
	[self addSubview:score];
	
	frame = CGRectMake(310, 290, 200, 30);
	[self addSubview:[Solitaire labelWithFrame:frame title:@"Time"]];

	frame = CGRectMake(360, 290, 200, 30);
	time = [Solitaire labelWithFrame:frame title:@"00:00"];
	[self addSubview:time];

}

- (void)showToolbar {
	toolbar.hidden = NO;
	[self bringSubviewToFront:toolbar];
}

- (void)timerTick {

	m_time++;

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];	
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setPositiveFormat:@"00"];
	
	NSNumber *minutes = [NSNumber numberWithFloat:(m_time / 60)];
	NSNumber *seconds = [NSNumber numberWithFloat:(m_time % 60)];
	
	time.text = [NSString stringWithFormat:@"%@:%@", 
				 [numberFormatter stringFromNumber:minutes], 
				 [numberFormatter stringFromNumber:seconds]];
}

- (void)stopTimer {
	if (repeatingTimer != nil) {
		[repeatingTimer invalidate];
		repeatingTimer = nil;
	}
}

- (void)startTimer {
	// first release existing timer
	[self stopTimer];
    
	NSMethodSignature *methodSignature = [self methodSignatureForSelector:@selector(timerTick)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(timerTick)];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 invocation:invocation repeats:YES];
    repeatingTimer = timer;	
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:repeatingTimer forMode:NSDefaultRunLoopMode];
}

- (void)initConstants {
	m_small = 3;
	m_large = 18;
	m_xBigShift = 15;
	m_xShift = 2;
	m_yShift = 1;
	m_cardHeight = 77;
	m_cardWidth = 53;
	m_timedGame = YES;
	m_score	= 0;
	m_scoring = SCORING_STANDARD;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		// InitConstants
		[self initConstants];

		// Toolbar
		[self createToolbar];
		
		// Card holders
		[self createCardHolders];
				
		// Init members
		m_win = NO;
		m_drawOne = YES;
		
		//self.backgroundColor = [UIColor colorWithRed:0.2 green:1.0 blue:0.6 alpha:1.0];
		
		[self deal];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder { 
	
	[coder encodeObject:@"hola" forKey:@"helo"]; 
	
	if (m_win) {
		
		[coder encodeBool:TRUE forKey:@"newGame"]; 
	
	} else {
	
		[coder encodeBool:FALSE forKey:@"newGame"]; 
		
		//int m_stacks[7][5][19];		// Stack array, (stack) (suit, card value, x, y , flipped) (index)
		for (int i=0; i<7; i++) {
			for (int j=0; j<5; j++) {
				for (int k=0; k<19; k++) {
					[coder encodeInt:m_stacks[i][j][k] forKey:[NSString stringWithFormat:@"stacks.%d.%d.%d", i, j, k]];
					//[coder encodeInt:-1 forKey:[NSString stringWithFormat:@"stacks.%d.%d.%d", i, j, k]];
				}
			}
		}
		//int m_deck[2][24];			// Deck array, (suit, card value) (index)
		for (int i=0; i<2; i++) {
			for (int j=0; j<24; j++) {
				[coder encodeInt:m_deck[i][j] forKey:[NSString stringWithFormat:@"deck.%d.%d", i, j]];
			}
		}
		//int m_drop[4][24];			// Drop array, (suit, card value) (index)
		for (int i=0; i<4; i++) {
			for (int j=0; j<24; j++) {
				[coder encodeInt:m_drop[i][j] forKey:[NSString stringWithFormat:@"drop.%d.%d", i, j]];
			}
		}
		//int m_drag[3][13];				// Drag array, (suit, card value, y) (index)
		for (int i=0; i<3; i++) {
			for (int j=0; j<13; j++) {
				[coder encodeInt:m_drag[i][j] forKey:[NSString stringWithFormat:@"drag.%d.%d", i, j]];
			}
		}
		//int m_aceStacks[4][2][13];		// Ace drop array, (stack) (suit, card value) (index) 
		for (int i=0; i<4; i++) {
			for (int j=0; j<2; j++) {
				for (int k=0; k<13; k++) {
					[coder encodeInt:m_aceStacks[i][j][k] forKey:[NSString stringWithFormat:@"aceStacks.%d.%d.%d", i, j, k]];
				}
			}
		}
		//int m_stackLengths[7];		// Length of stack (one greater than last used index)
		for (int i=0; i<7; i++) {
			[coder encodeInt:m_stackLengths[i] forKey:[NSString stringWithFormat:@"stackLengths.%d", i]];
		}
		//int m_deckLength;			// Cards in dealing deck, -1 when flipping over deck
		[coder encodeInt:m_deckLength forKey:@"deckLength"];
		
		//int m_dropLength;			// Cards in dropping deck
		[coder encodeInt:m_dropLength forKey:@"dropLength"];
		
		//int m_dragLength;			// Cards in drag/drop action
		[coder encodeInt:m_dragLength forKey:@"dragLength"];
		
		//int m_aceStackLengths[4];	// Cards in each ace drop
		for (int i=0; i<4; i++) {
			[coder encodeInt:m_aceStackLengths[i] forKey:[NSString stringWithFormat:@"aceStackLengths.%d", i]];
		}
		//int m_hitCard;				// Card that the mouse was over when dragging, needed for multiple card drag
		[coder encodeInt:m_hitCard forKey:@"hitCard"];
		
		//BOOL m_dragging;			// True when drag/drop in process
		[coder encodeBool:m_dragging forKey:@"dragging"];
		
		//int m_cycleDeck;            // Number of times player has flipped the deck
		[coder encodeInt:m_cycleDeck forKey:@"cycleDeck"];
		
		//int m_aceLocation[2][4];	// X, Y and suit for ace drops
		for (int i=0; i<2; i++) {
			for (int j=0; j<4; j++) {
				[coder encodeInt:m_aceLocation[i][j] forKey:[NSString stringWithFormat:@"aceLocation.%d.%d", i, j]];
			}
		}
		//int m_undoType;				// Undo type for switch and to get info from undo array
		[coder encodeInt:m_undoType forKey:@"undoType"];
		
		//int m_undo[7][3];			// Keeps undo information (type) (data)
		for (int i=0; i<7; i++) {
			for (int j=0; j<3; j++) {
				[coder encodeInt:m_undo[i][j] forKey:[NSString stringWithFormat:@"undo.%d.%d", i, j]];
			}
		}
		
		// Settings
		//int m_scoring;				// Type of scoring (standar, vegas, vegas cumulative)
		[coder encodeInt:m_scoring forKey:@"scoring"];
		
		//BOOL m_drawOne;             // True when draggin one card not 3 
		[coder encodeBool:m_drawOne forKey:@"drawOne"];
		
		//BOOL m_timedGame;           // True if game is timed 
		[coder encodeBool:m_timedGame forKey:@"timedGame"];
		
		//int m_score;				// Score if keeping score
		[coder encodeInt:m_score forKey:@"score"]; 
		
		//int m_time;					// Time if keeping time
		[coder encodeInt:m_time forKey:@"time"]; 
		
		//int m_cardHeight;			// Card height and width
		[coder encodeInt:m_cardHeight forKey:@"cardHeight"]; 
		
		//int m_cardWidth;			//
		[coder encodeInt:m_cardWidth forKey:@"cardWidth"]; 
		
		//int m_xBigShift;			// For drop panel
		[coder encodeInt:m_xBigShift forKey:@"xBigShift"]; 
		
		//int m_yShift;				// 
		[coder encodeInt:m_yShift forKey:@"yShift"]; 
		
		//int m_xShift;				// 
		[coder encodeInt:m_xShift forKey:@"xShift"]; 
		
		//int m_small;                // Unflipped card Y shift
		[coder encodeInt:m_small forKey:@"small"]; 
		
		//int m_large;                // Flipped card Y shift
		[coder encodeInt:m_large forKey:@"large"]; 
		
		//[coder encodeObject:cardsSpades forKey:@"cardsSpades"]; 
		//[coder encodeObject:cardsDiamonds forKey:@"cardsDiamonds"]; 
		//[coder encodeObject:cardsClubs forKey:@"cardsClubs"]; 
		//[coder encodeObject:cardsHearts forKey:@"cardsHearts"]; 
	}
	[coder encodeObject:@"chau" forKey:@"goodbye"]; 
}

- (void)doPaint:(int)stack View:(UIImageView*)view {
	int i = 0;
	int suit = 0;
	int cardValue = 0;
	int y = 0;
	int flipped = 1;
	int index = 0;
	CardView *cardView;
	
	// TODO: delete debug Remove this flag
#if DEBUG	
	int debugFlag = 0;
#endif
		
	if (stack < 7) {

		index = m_stackLengths[stack];
		
		for (i=0; i<index; i++) {
			if (stack < 7) {
				suit = m_stacks[stack][0][i];
				cardValue = m_stacks[stack][1][i];
				y = m_stacks[stack][3][i];
				flipped = m_stacks[stack][4][i];
			}
			
			if (cardValue == -1) {
				m_stackLengths[stack] = i;
				break;
			}
			else {

				if (suit == 0 ) { // Spades
					// put image in the stack
					cardView = [cardsSpades objectAtIndex:cardValue];
				} else if (suit == 1 ) { // Diamonds
					// put image in the stack
					cardView = [cardsDiamonds objectAtIndex:cardValue];
				} else if (suit == 2 ) { // Clubs
					// put image in the stack
					cardView = [cardsClubs objectAtIndex:cardValue];
				} else { // Hearts
					// put image in the stack
					cardView = [cardsHearts objectAtIndex:cardValue];
				}
				cardView.frame = CGRectMake(view.frame.origin.x, 
											view.frame.origin.y + y,
											cardView.frame.size.width,
											cardView.frame.size.height);
				
				if (flipped == 0) {
					cardView.flipped = NO;
					cardView.image = cardBack;
					cardView.userInteractionEnabled = NO;
					
					// TODO: debug delete
#if DEBUG
					if (debugFlag == 1) {
						debugShow(@"There is one card not flipped as the last card in one stack");
					}
#endif				
					// TODO: debug delete fin
				}else {
					cardView.flipped = YES;
					cardView.image = cardView.cardImage;
					cardView.userInteractionEnabled = YES;
					// TODO: debug delete
#if DEBUG
					debugFlag = 1; 
#endif
				}
				cardView.hidden = NO;
				cardView.inDeck = NO;
				cardView.inDropPanel = NO;
				cardView.stack = stack;
				[self addSubview:cardView];
				[self bringSubviewToFront:cardView];				
			}
		}
	}
}

- (void)doPaintDeck:(NSMutableArray*)cards {
	int i;
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (cardView.inDeck) {
			cardView.frame = CGRectMake(deckToDeal.frame.origin.x, 
										deckToDeal.frame.origin.y, // TODO: probably we have to use y variable to send down the card
										cardView.frame.size.width,
										cardView.frame.size.height);
			cardView.image = cardBack;
			cardView.hidden = NO;
			cardView.inDeck = YES;
			cardView.inDropPanel = NO;
			cardView.stack = 7; // Drop panel
			cardView.userInteractionEnabled = YES;
		}
	}	
}

- (void)validateStack:(NSMutableArray*)cards {
	int i,j;
	CardView *cardView;
	
	for (i=1; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (cardView.stack-8 >=0) {
			for (j=0; j<4; j++) {
				if (m_aceStacks[j][0][0] == cardView.suit) {
					switch (j) {
						case 0:
							cardView.center = ace0.center;
							break;							
						case 1:
							cardView.center = ace1.center;
							break;							
						case 2:
							cardView.center = ace2.center;
							break;							
						case 3:
							cardView.center = ace3.center;							
							break;
						default:
							break;
					}
				}
			}
		}
	}	
}

- (void)validateDropPanel:(NSMutableArray*)cards {
	int i;
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (cardView.inDropPanel) {
			cardView.center = dropPanel.center;
		}
	}	
}

// 1- Cuando se ejecuta managedropcard hay que validar:
- (void)validateGame {
	// 1 que si no existen cartas en el deck, el deck acepte el tap
	if (m_deckLength == 0) {
		deckToDeal.userInteractionEnabled = YES;
	}
	
	// 2 que si existen cartas en el deck que dichas cartas esten en la posicion del deck
	// y que esten con flip = 0
	[self doPaintDeck:cardsSpades];
	[self doPaintDeck:cardsDiamonds];
	[self doPaintDeck:cardsClubs];
	[self doPaintDeck:cardsHearts];
	
	// 3 que si una carta esta en el stack, dicha carta este en el stack que le 
	// corresponde segun su suit (fijarse en que stack esta el as) si esta mal
	// pasarla al stack que corresponda o devolverla al deck
	[self validateStack:cardsSpades];
	[self validateStack:cardsDiamonds];
	[self validateStack:cardsClubs];
	[self validateStack:cardsHearts];
	
	// 4 que si una carta esta en el deck o en el drop panel su posicion sea valida
	// y no se halla desplazado hacia algun stack (los de abajo o los de aces)
	[self validateDropPanel:cardsSpades];
	[self validateDropPanel:cardsDiamonds];
	[self validateDropPanel:cardsClubs];
	[self validateDropPanel:cardsHearts];
	
}

- (CardView*)getCardFromStackSuit:(int)suit CardValue:(int)cardValue {
	
	if (suit == 0) { // Spades
		// put image in the stack
		return [cardsSpades objectAtIndex:cardValue];
	} else if (suit == 1 ) { // Diamonds
		// put image in the stack
		return [cardsDiamonds objectAtIndex:cardValue];
	} else if (suit == 2 ) { // Clubs
		// put image in the stack
		return [cardsClubs objectAtIndex:cardValue];
	} else { // Hearts
		// put image in the stack
		return [cardsHearts objectAtIndex:cardValue];
	}
}

- (void)enabledTopCardInStack:(int)stack {
	if (stack < 7) { // Stacks
		if (m_stackLengths[stack] > 0) {
			
			int topCardSuit  = m_stacks[stack][0][m_stackLengths[stack]-1];
			int topCardValue = m_stacks[stack][1][m_stackLengths[stack]-1];
			
			CardView *topCard = [self getCardFromStackSuit:topCardSuit CardValue:topCardValue];
			topCard.userInteractionEnabled = YES;
		}
		
	} else if (stack == 7) { // Drop panel
		if (m_dropLength > 0) {
			
			int topCardSuit  = m_drop[0][m_dropLength-1];
			int topCardValue = m_drop[1][m_dropLength-1];
			
			CardView *topCard = [self getCardFromStackSuit:topCardSuit CardValue:topCardValue];
			topCard.userInteractionEnabled = YES;
		}
		
	} else { // Aces
		stack = stack -8;
		if (m_aceStackLengths[stack] > 0) {
			
			int topCardSuit  = m_aceStacks[stack][0][m_aceStackLengths[stack]-1];
			int topCardValue = m_aceStacks[stack][1][m_aceStackLengths[stack]-1];
			
			CardView *topCard = [self getCardFromStackSuit:topCardSuit CardValue:topCardValue];
			topCard.userInteractionEnabled = YES;
		}
	}
}

- (void)hideCards:(NSMutableArray*)cards {
	int i;
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (cardView.inDeck) {
			cardView.hidden = YES;
			cardView.flipped = NO;
			cardView.userInteractionEnabled = YES;
			[cardView removeFromSuperview];
		}
	}	
}

- (void) loadDeck {

	for (int i=0; i<m_deckLength; i++) {
		
		int cardSuit  = m_deck[0][i];
		int cardValue = m_deck[1][i];
		
		CardView *card = [self getCardFromStackSuit:cardSuit CardValue:cardValue];
		
		card.inDeck = YES;
		card.stack = 0;
		
	}
	
	[self hideCards:cardsSpades];
	[self hideCards:cardsDiamonds];
	[self hideCards:cardsClubs];
	[self hideCards:cardsHearts];
	
	[self setOrderInDeck];
	
	[self doPaintDeck:cardsSpades];
	[self doPaintDeck:cardsDiamonds];
	[self doPaintDeck:cardsClubs];
	[self doPaintDeck:cardsHearts];
	
	if (m_deckLength > 0) {
		deckToDeal.userInteractionEnabled = NO;
	}
	
	for (int i=0; i<m_dropLength; i++) {
		
		int cardSuit  = m_drop[0][i];
		int cardValue = m_drop[1][i];
		
		CardView *card = [self getCardFromStackSuit:cardSuit CardValue:cardValue];

		card.frame = CGRectMake(DROP_PANEL_LEFT, DROP_PANEL_TOP, card.frame.size.width, card.frame.size.height);
		card.image = card.cardImage;
		card.flipped = YES;
		card.inDeck = NO;
		card.inDropPanel = YES;
		card.stack = 7;
		
		//[self bringSubviewToFront:card];
		//[self managePickCard:card];
		[self addSubview:card];
		[self setTopCardInDeck:card];
	}

}

- (void) loadStackAces {
	
	UIImageView *stackPanel;

	for (int stack=0; stack<4; stack++) {

		for (int i=0; i<m_aceStackLengths[stack]; i++) {

			int cardSuit  = m_aceStacks[stack][0][i];
			int cardValue = m_aceStacks[stack][1][i];
				
			CardView *card = [self getCardFromStackSuit:cardSuit CardValue:cardValue];
			
			switch (stack) {
				case 0:
					stackPanel = ace0;
					break;
				case 1:
					stackPanel = ace1;
					break;
				case 2:
					stackPanel = ace2;
					break;
				case 3:
					stackPanel = ace3;
					break;
				default:
					break;
			}
			// Set card position
			card.frame = stackPanel.frame;
			
			// New stack
			card.stack = stack + 8; // 8 to 11 ace stacks
			card.inDeck = NO;
			card.inDropPanel = NO;	
			card.image = card.cardImage;
			card.flipped = YES;
			
			[card removeFromSuperview];
			[self addSubview:card];
			
		}
	}
}

- (id) initWithCoder:(NSCoder *)coder { 
	if (self = [super init]) {

		[self initWithFrame:CGRectMake(0,0,480,320)];
		
		NSString *strVar = [coder decodeObjectForKey:@"helo"]; 
		if ([strVar isEqualToString:@"hola"]) {
			
			strVar = [coder decodeObjectForKey:@"goodbye"];
			
			if ([strVar isEqualToString:@"chau"]) {
				
				BOOL newGame = [coder decodeBoolForKey:@"newGame"]; 
		
				if (!newGame) {

					//int m_stacks[7][5][19];		// Stack array, (stack) (suit, card value, x, y , flipped) (index)
					for (int i=0; i<7; i++) {
						for (int j=0; j<5; j++) {
							for (int k=0; k<19; k++) {
								m_stacks[i][j][k] = [coder decodeIntForKey:[NSString stringWithFormat:@"stacks.%d.%d.%d", i, j, k]];
							}
						}
					}
					//int m_deck[2][24];			// Deck array, (suit, card value) (index)
					for (int i=0; i<2; i++) {
						for (int j=0; j<24; j++) {
							m_deck[i][j] = [coder decodeIntForKey:[NSString stringWithFormat:@"deck.%d.%d", i, j]];
						}
					}
					//int m_drop[4][24];			// Drop array, (suit, card value) (index)
					for (int i=0; i<4; i++) {
						for (int j=0; j<24; j++) {
							m_drop[i][j] = [coder decodeIntForKey:[NSString stringWithFormat:@"drop.%d.%d", i, j]];
						}
					}
					//int m_drag[3][13];				// Drag array, (suit, card value, y) (index)
					for (int i=0; i<3; i++) {
						for (int j=0; j<13; j++) {
							m_drag[i][j] = [coder decodeIntForKey:[NSString stringWithFormat:@"drag.%d.%d", i, j]];							
						}
					}
					//int m_aceStacks[4][2][13];		// Ace drop array, (stack) (suit, card value) (index) 
					for (int i=0; i<4; i++) {
						for (int j=0; j<2; j++) {
							for (int k=0; k<13; k++) {
								m_aceStacks[i][j][k] = [coder decodeIntForKey:[NSString stringWithFormat:@"aceStacks.%d.%d.%d", i, j, k]];
							}
						}
					}
					//int m_stackLengths[7];		// Length of stack (one greater than last used index)
					for (int i=0; i<7; i++) {
						m_stackLengths[i] = [coder decodeIntForKey:[NSString stringWithFormat:@"stackLengths.%d", i]];
					}
					
					//int m_deckLength;			// Cards in dealing deck, -1 when flipping over deck
					m_deckLength = [coder decodeIntForKey:@"deckLength"];
					
					//int m_dropLength;			// Cards in dropping deck
					m_dropLength = [coder decodeIntForKey:@"dropLength"];
					
					//int m_dragLength;			// Cards in drag/drop action
					m_dragLength = [coder decodeIntForKey:@"dragLength"];
					
					//int m_aceStackLengths[4];	// Cards in each ace drop
					for (int i=0; i<4; i++) {
						m_aceStackLengths[i] = [coder decodeIntForKey:[NSString stringWithFormat:@"aceStackLengths.%d", i]];
					}
					//int m_hitCard;				// Card that the mouse was over when dragging, needed for multiple card drag
					m_hitCard = [coder decodeIntForKey:@"hitCard"];
					
					//BOOL m_dragging;			// True when drag/drop in process
					m_dragging = [coder decodeBoolForKey:@"dragging"];
					
					//int m_cycleDeck;            // Number of times player has flipped the deck
					m_cycleDeck = [coder decodeIntForKey:@"cycleDeck"];
					
					//int m_aceLocation[2][4];	// X, Y and suit for ace drops
					for (int i=0; i<2; i++) {
						for (int j=0; j<4; j++) {
							m_aceLocation[i][j] = [coder decodeIntForKey:[NSString stringWithFormat:@"aceLocation.%d.%d", i, j]];							
						}
					}
					//int m_undoType;				// Undo type for switch and to get info from undo array
					m_undoType = [coder decodeIntForKey:@"undoType"];
					
					//int m_undo[7][3];			// Keeps undo information (type) (data)
					for (int i=0; i<7; i++) {
						for (int j=0; j<3; j++) {
							m_undo[i][j] = [coder decodeIntForKey:[NSString stringWithFormat:@"undo.%d.%d", i, j]];							
						}
					}
					
					// Settings
					//int m_scoring;				// Type of scoring (standar, vegas, vegas cumulative)
					m_scoring = [coder decodeIntForKey:@"scoring"];
					
					//BOOL m_drawOne;             // True when draggin one card not 3 
					m_drawOne = [coder decodeBoolForKey:@"drawOne"];
					
					//BOOL m_timedGame;           // True if game is timed 
					m_timedGame = [coder decodeBoolForKey:@"timedGame"];
					
					//int m_score;				// Score if keeping score
					m_score = [coder decodeIntForKey:@"score"];
					
					//int m_time;					// Time if keeping time
					m_time = [coder decodeIntForKey:@"time"];
					
					//int m_cardHeight;			// Card height and width
					m_cardHeight = [coder decodeIntForKey:@"cardHeight"];
					
					//int m_cardWidth;			//
					m_cardWidth = [coder decodeIntForKey:@"cardWidth"];
					
					//int m_xBigShift;			// For drop panel
					m_xBigShift = [coder decodeIntForKey:@"xBigShift"];
					
					//int m_yShift;				// 
					m_yShift = [coder decodeIntForKey:@"yShift"];
					
					//int m_xShift;				// 
					m_xShift = [coder decodeIntForKey:@"xShift"];
					
					//int m_small;                // Unflipped card Y shift
					m_small = [coder decodeIntForKey:@"small"];
					
					//int m_large;                // Flipped card Y shift
					m_large = [coder decodeIntForKey:@"large"];
					
					//cardsSpades		= [coder decodeObjectForKey:@"cardsSpades"]; 
					//cardsDiamonds		= [coder decodeObjectForKey:@"cardsDiamonds"]; 
					//cardsClubs		= [coder decodeObjectForKey:@"cardsClubs"]; 
					//cardsHearts		= [coder decodeObjectForKey:@"cardsHearts"]; 

					CardView *card;
					for (int i=1; i<13; i++) {
						card = [cardsSpades objectAtIndex:i];
						card.stack = 7;
						[card removeFromSuperview];
					}
					for (int i=1; i<13; i++) {
						card = [cardsDiamonds objectAtIndex:i];
						card.stack = 7;
						[card removeFromSuperview];
					}for (int i=1; i<13; i++) {
						card = [cardsClubs objectAtIndex:i];
						card.stack = 7;
						[card removeFromSuperview];
					}for (int i=1; i<13; i++) {
						card = [cardsHearts objectAtIndex:i];
						card.stack = 7;
						[card removeFromSuperview];
					}

					[self loadStackAces];
					[self loadDeck];
					
					deckToDeal.userInteractionEnabled = NO;
					
					[self validateGame];
					
					[self doPaint:0 View:stack0];
					[self doPaint:1 View:stack1];
					[self doPaint:2 View:stack2];
					[self doPaint:3 View:stack3];
					[self doPaint:4 View:stack4];
					[self doPaint:5 View:stack5];
					[self doPaint:6 View:stack6];
					
//					[self setOrderInDeck];
					
					[self doPaintDeck:cardsSpades];
					[self doPaintDeck:cardsDiamonds];
					[self doPaintDeck:cardsClubs];
					[self doPaintDeck:cardsHearts];

/*					
					[self loadStackAces];
					[self loadDeck];
					
					deckToDeal.userInteractionEnabled = NO;
					
					[self validateGame];
*/					
					[self enabledTopCardInStack:0];
					[self enabledTopCardInStack:1];
					[self enabledTopCardInStack:2];
					[self enabledTopCardInStack:3];
					[self enabledTopCardInStack:4];
					[self enabledTopCardInStack:5];
					[self enabledTopCardInStack:6];
					[self enabledTopCardInStack:7];
					[self enabledTopCardInStack:8];
					[self enabledTopCardInStack:9];
					[self enabledTopCardInStack:10];
					[self enabledTopCardInStack:11];
				}
			}
		}
	} return self; 
} 

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[deckToDeal release];
	[toolbar release];
	[cardBack release];
	[ace0 release];
	[ace1 release];
	[ace2 release];
	[ace3 release];
	[stack0 release];
	[stack1 release];
	[stack2 release];
	[stack3 release];
	[stack4 release];
	[stack5 release];
	[stack6 release];
	[cardsSpades release];
	[cardsDiamonds release];
	[cardsClubs release];
	[cardsHearts release];
	[score release]; 
	[time release];
	[repeatingTimer release];
    [super dealloc];
}

- (void)deal {
	
	m_time = 0;
	m_win = NO;

	[self stopTimer];

	CardView *card;
	int i=0, j=0, k=0;
	
	CGRect cardFrame = CGRectMake(0, 0, 57, 77);
	
	// load cards
	if (cardsSpades == nil) {
		
		cardsSpades = [[NSMutableArray alloc] initWithCapacity:13];
		
		for (i=0; i<13; i++) {
			
			NSString *idx = [NSString stringWithFormat:@"%d", i + 1];
			NSString *cardName = [NSString stringWithFormat:@"%@%@%@", @"Spades", idx, @"c.png"];
			
			card = [[CardView alloc] initWithFrame:cardFrame];
			card.cardImage = [UIImage imageNamed:cardName];
			card.suit = 0;
			card.cardValue = i;
			[cardsSpades insertObject:card atIndex:i];
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.stack = 0;
			[card release];
		}
	} else {
		
		for (i=0; i<13; i++) {
			
			card = [cardsSpades objectAtIndex:i];
			[card resetCard];
			card.suit = 0;
			card.cardValue = i;
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.flipped = NO;
			card.stack = 0;
			[card removeFromSuperview];
		}		
	}
	
	if (cardsDiamonds == nil) {
		
		cardsDiamonds = [[NSMutableArray alloc] initWithCapacity:13];
		
		for (i=0; i<13; i++) {
			
			NSString *idx = [NSString stringWithFormat:@"%d", i+1];
			NSString *cardName = [NSString stringWithFormat:@"%@%@%@", @"Diamonds", idx, @"c.png"];
			
			card = [[CardView alloc] initWithFrame:cardFrame];
			card.cardImage = [UIImage imageNamed:cardName];
			card.suit = 1;
			card.cardValue = i;
			[cardsDiamonds insertObject:card atIndex:i];
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.stack = 0;
			[card release];
		}
	} else {
		
		for (i=0; i<13; i++) {
			
			card = [cardsDiamonds objectAtIndex:i];
			[card resetCard];
			card.suit = 1;
			card.cardValue = i;
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.flipped = NO;
			card.stack = 0;
			[card removeFromSuperview];
		}		
	}
	
	if (cardsClubs == nil) {
		
		cardsClubs = [[NSMutableArray alloc] initWithCapacity:13];
		
		for (i=0; i<13; i++) {
			
			NSString *idx = [NSString stringWithFormat:@"%d", i+1];
			NSString *cardName = [NSString stringWithFormat:@"%@%@%@", @"Clubs", idx, @"c.png"];
			
			card = [[CardView alloc] initWithFrame:cardFrame];
			card.cardImage = [UIImage imageNamed:cardName];
			card.suit = 2;
			card.cardValue = i;
			[cardsClubs insertObject:card atIndex:i];
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.stack = 0;
			[card release];
		}
	} else {
		
		for (i=0; i<13; i++) {
			
			card = [cardsClubs objectAtIndex:i];
			[card resetCard];
			card.suit = 2;
			card.cardValue = i;
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.flipped = NO;
			card.stack = 0;
			[card removeFromSuperview];
		}		
	}	
	
	if (cardsHearts == nil) {
		
		cardsHearts = [[NSMutableArray alloc] initWithCapacity:13];
		
		for (i=0; i<13; i++) {
			
			NSString *idx = [NSString stringWithFormat:@"%d", i+1];
			NSString *cardName = [NSString stringWithFormat:@"%@%@%@", @"Heart", idx, @"c.png"];
			
			card = [[CardView alloc] initWithFrame:cardFrame];
			card.cardImage = [UIImage imageNamed:cardName];
			card.suit = 3;
			card.cardValue = i;
			[cardsHearts insertObject:card atIndex:i];
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.stack = 0;
			[card release];
		}
	} else {
		
		for (i=0; i<13; i++) {
			
			card = [cardsHearts objectAtIndex:i];
			[card resetCard];
			card.suit = 3;
			card.cardValue = i;
			card.hidden = YES;
			card.inDeck = YES;
			card.inDropPanel = NO;
			card.flipped = NO;
			card.stack = 0;
			[card removeFromSuperview];
		}		
	}	
	
	// card logic
	int vcards[4][13]; // Temporary array for picking out cards (pseudoshuffle)
	CGPoint suitCard = CGPointMake(0,0);

	m_deckLength = 24;
	m_cycleDeck = 0;
	
	// TODO: delete debug
#if DEBUG	
	int vdcards[4][13];
#endif
	// TODO: delete debug fin
	
	[self updateStatus];
	
	// Initialize cards
	for (i=0; i<4; i++) {
		for (j=0; j<13; j++) {
			vcards[i][j] = -1;
		}
	}
	
	// Initialize aces
	for (i=0; i<4; i++) {
		m_aceStackLengths[i] = 0;
	}
	for (i=0; i<4; i++) {
		for (j=0; j<13; j++) {
			m_aceStacks[i][0][j] = -1;
			m_aceStacks[i][1][j] = -1;
		}
	}
	
	// Clear stacks
	for (i=0; i<7; i++) {
		for (j=0; j<5; j++) {
			for (k=0; k<19; k++) {
				m_stacks[i][j][k] = -1;
			}
		}
	}
	
	// Clear deck
	for (i=0; i<m_deckLength; i++) {
		m_deck[0][i] = 0;
		m_deck[1][i] = 0;
	}
	
	// Clear drop
	for (i=0; i<m_deckLength; i++) {
		m_drop[0][i] = 0;
		m_drop[1][i] = 0;
	}
	
	// Clear drag
	for (i=0; i<13; i++) {
		m_drag[0][i] = 0;
		m_drag[1][i] = 0;
		m_drag[2][i] = 0;		
	}
	m_dragLength = 0;
	m_dropLength = 0;
	
	// Reset DragBox
	
	for (i=0; i<7; i++) {
		int y = 0;
		// Darddepth up to stack #
		for (j=0; j<i; j++) {
			suitCard = [self nextCard:vcards];
			// Stack, suit, cardValue, x, y, flipped, index
			[self setCardStack:i Suit:suitCard.x CardValue:suitCard.y X:0 Y:y Flipped:0 Index:j]; 
			y += m_small;
		}
		// Last card is flipped up
		suitCard = [self nextCard:vcards];
		// Stack, suit, cardValue, x, y, flipped, index = stack
		[self setCardStack:i Suit:suitCard.x CardValue:suitCard.y X:0 Y:y Flipped:1 Index:i];
	}
	
	// TODO: delete debug
#if DEBUG	
	for (i=0; i<4; i++) {
		for (j=0; j<13; j++) {
			vdcards[i][j] = vcards[i][j];
		}
	}
#endif
	// TODO: delete debug fin
	
	// Set deck
	int kk = 0;
	
	for (i=0; i<4; i++) {
		for (j=0; j<13; j++) {
			if (vcards[i][j] == -1 /*0*/) {
				vcards[i][j] = 1;
				m_deck[0][kk] = i;
				m_deck[1][kk] = j;
				kk += 1;
			}
		}
	}
	
	// TODO: delete debug
#if DEBUG	
	for (kk=0; kk<m_deckLength; kk++) {
		if (vdcards[m_deck[0][kk]][m_deck[1][kk]] != -1/*0*/) {
			debugShow(@"There is one card used in both, the stack and deck before shufle");
		}
	}
#endif	
	// TODO: delete debug fin
	
	[self shuffle];
	
	// TODO: delete debug
#if DEBUG	
	for (kk=0; kk<m_deckLength; kk++) {
		if (vdcards[m_deck[0][kk]][m_deck[1][kk]] != -1/*0*/) {
			debugShow(@"There is one card used in both, the stack and deck after shufle");
		}
	}
#endif
	// TODO: delete debug fin
	
	// Clear or set variables
	for (i=0; i<7; i++) {
		m_stackLengths[i] = i+1;
	}
	for (i=0; i<4; i++) {
		m_aceStackLengths[i] = 0;
	}
	m_cycleDeck = 1;
	
	// TODO: scoring options
	if (m_scoring == SCORING_STANDARD) {
		m_score = 0;
	} else if (m_scoring == SCORING_VEGAS) {
		m_score = -52;
	} else if (m_scoring == SCORING_VEGAS_CUMULATIVE) {
		m_score += -52;
	}
	
	// Timer
	m_time = 0;
	// TODO: timer for time
	
	[self doPaint:0 View:stack0];
	[self doPaint:1 View:stack1];
	[self doPaint:2 View:stack2];
	[self doPaint:3 View:stack3];
	[self doPaint:4 View:stack4];
	[self doPaint:5 View:stack5];
	[self doPaint:6 View:stack6];
	
	[self setOrderInDeck];
	
	[self doPaintDeck:cardsSpades];
	[self doPaintDeck:cardsDiamonds];
	[self doPaintDeck:cardsClubs];
	[self doPaintDeck:cardsHearts];
	
	deckToDeal.userInteractionEnabled = NO; 
	
	m_hitCard = 0;
		
}

- (void)configDeck {
	
	UIView *view;
	
	// Start Animation Block
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:[self superview] cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	// Animations
	
	// Commit Animation Block
	[UIView commitAnimations];
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_DECK];
	view.hidden = NO;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_OPTIONS];
	view.hidden = YES;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_SOLITAIRE];
	view.hidden = YES;
	
}

- (void)editOptions {
	UIView *view;
	
	// Start Animation Block
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:[self superview] cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	// Animations
	
	// Commit Animation Block
	[UIView commitAnimations];
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_OPTIONS];
	view.hidden = NO;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_DECK];
	view.hidden = YES;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_SOLITAIRE];
	view.hidden = YES;	
}

- (void)updateCardBackImageInCards:(NSMutableArray*)cards {
	int i;
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (!cardView.flipped) {
			cardView.image = cardBack;
		}
	}	
}

- (void)updateCardBackImage:(int)index {
	
	if (imageCardBack != index) {
		imageCardBack = index;
		[self setCardBackImage:imageCardBack];
		[self updateCardBackImageInCards:cardsSpades];
		[self updateCardBackImageInCards:cardsDiamonds];
		[self updateCardBackImageInCards:cardsClubs];
		[self updateCardBackImageInCards:cardsHearts];
	}
}

- (void)setOrderInDeck {
	
	int i;
	int suit;
	int cardValue;
	CardView *cardView;
	
	for (i=0; i<m_deckLength; i++) {
		
		suit = m_deck[0][i];
		cardValue = m_deck[1][i];
		
		if (suit == 0 ) { // Spades
			// put image in the stack
			cardView = [cardsSpades objectAtIndex:cardValue];
		} else if (suit == 1 ) { // Diamonds
			// put image in the stack
			cardView = [cardsDiamonds objectAtIndex:cardValue];
		} else if (suit == 2 ) { // Clubs
			// put image in the stack
			cardView = [cardsClubs objectAtIndex:cardValue];
		} else { // Hearts
			// put image in the stack
			cardView = [cardsHearts objectAtIndex:cardValue];
		}
		
		cardView.inDeck = YES;
		cardView.inDropPanel = NO;
		cardView.userInteractionEnabled = YES;
		
		[self addSubview:cardView];
	}
	
#if DEBUG
	for (int i=0; i<m_deckLength; i++) {
		for (int j=0; j<m_deckLength; j++) {
			if (m_deck[0][i] == m_deck[0][j] && m_deck[1][i] == m_deck[1][j] && i != j) {
				debugShow(@"There is one card that is in the deck more than one time");
			}
		}
	}
#endif
}

- (void)reloadDeckArray {
	// Set undo information
	m_undoType = 6;
	
	m_cycleDeck++;
	m_deckLength = m_dropLength;
	
	int k=0;
	for (int i=m_dropLength-1; i>=0; i--) {
		m_deck[0][k] = m_drop[0][i];
		m_deck[1][k] = m_drop[1][i];
		CardView *card = [self getCardFromStackSuit:m_deck[0][k] CardValue:m_deck[1][k]];
		card.inDeck = YES;
		card.inDropPanel = NO;
		k++;
	}
	m_dropLength = 0;
	
	// Scoring
	if (m_scoring == SCORING_STANDARD && m_cycleDeck > 3 && !m_drawOne) {
		m_score -= 20;
	} else if (m_scoring == SCORING_STANDARD && m_cycleDeck > 1 && m_drawOne) {
		m_score -= 100;
	}
	if (m_scoring != SCORING_NONE) {
		[self updateStatus];
	}
	// TODO enabled undo
}

- (void)reloadDeckToDeal {

	[self reloadDeckArray];
	
	[self hideCards:cardsSpades];
	[self hideCards:cardsDiamonds];
	[self hideCards:cardsClubs];
	[self hideCards:cardsHearts];
	
	[self setOrderInDeck];
	
	[self doPaintDeck:cardsSpades];
	[self doPaintDeck:cardsDiamonds];
	[self doPaintDeck:cardsClubs];
	[self doPaintDeck:cardsHearts];

	deckToDeal.userInteractionEnabled = NO;
}

- (void)setTopCardInDeck:(CardView*)card Cards:(NSMutableArray*)cards {
	int i;
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		
		// put image in the stack
		cardView = [cards objectAtIndex:i];
		if (cardView.flipped && card != cardView && cardView.inDropPanel) {
			cardView.userInteractionEnabled = NO;
		}
	}	
	
}

- (void)setTopCardInDeck:(CardView*)card {
	[self setTopCardInDeck:card Cards:cardsSpades];
	[self setTopCardInDeck:card Cards:cardsDiamonds];
	[self setTopCardInDeck:card Cards:cardsClubs];
	[self setTopCardInDeck:card Cards:cardsHearts];
}

- (UIImageView*)getStack:(int)index {
	switch (index) {
		case 0:
			return stack0;
			break;
		case 1:
			return stack1;
			break;
		case 2:
			return stack2; 
			break;
		case 3:
			return stack3; 
			break;
		case 4:
			return stack4; 
			break;
		case 5:
			return stack5; 
			break;
		case 6:
			return stack6; 
			break;
		case 7:
			return dropPanel;
			break;
		case 8:
			return ace0; 
			break;
		case 9:
			return ace1; 
			break;
		case 10:
			return ace2; 
			break;
		case 11:
			return ace3;
			break;

		default:
			return nil;
			break;
	}
}

- (BOOL)isOverStack:(UIImageView*)stack StackIndex:(int)i CardCenter:(CGPoint)point {
	int left, right, top, bottom;
	
	left   = stack.frame.origin.x;
	top    = stack.frame.origin.y;
	right  = left + stack.frame.size.width;
	bottom = top + stack.frame.size.height;
	
	if (i < 7) {
		if (m_stackLengths[i] > 0) {
			for (int j=0; j < m_stackLengths[i]; j++) {
				if (m_stacks[i][4][j] != -1/*0*/) {
					bottom += m_large;
				} else {
					bottom += m_small;
				}
			} 
		}
	}
	
	if(	  point.x >= left
	   && point.y >= top
	   && point.x <= right
	   && point.y <= bottom
	   ) {
		return YES;
	}
	else {
		return NO;
	}	
}

/*
- (void)enabledBelowCardInStack:(int)stack {
	if (stack < 7) { // Stacks
		if (m_stackLengths[stack] > 0) {
			
			int belowCardSuit  = m_stacks[stack][0][m_stackLengths[stack]-1];
			int belowCardValue = m_stacks[stack][1][m_stackLengths[stack]-1];
			
			CardView *aboveCard = [self getCardFromStackSuit:belowCardSuit CardValue:belowCardValue];
			aboveCard.userInteractionEnabled = YES;
		}
		
	} else if (stack == 7) { // Drop panel
		if (m_dropLength > 0) {
			
			int belowCardSuit  = m_drop[0][m_dropLength-1];
			int belowCardValue = m_drop[1][m_dropLength-1];
			
			CardView *aboveCard = [self getCardFromStackSuit:belowCardSuit CardValue:belowCardValue];
			aboveCard.userInteractionEnabled = YES;
		}
		
	} else { // Aces
		stack = stack -8;
		if (m_aceStackLengths[stack] > 0) {
			
			int belowCardSuit  = m_aceStacks[stack][0][m_aceStackLengths[stack]-1];
			int belowCardValue = m_aceStacks[stack][1][m_aceStackLengths[stack]-1];
			
			CardView *aboveCard = [self getCardFromStackSuit:belowCardSuit CardValue:belowCardValue];
			aboveCard.userInteractionEnabled = YES;
		}
	}
}
*/

- (void)validateStackLengths {
	
	int i;
	int stackLengths[12];
	for (i=0; i<12; i++) 
		stackLengths[i] =0;
	
	CardView *cardView;
	
	for (i=0; i<13; i++) {
		cardView = [cardsSpades objectAtIndex:i];
		if (!cardView.inDeck)
			stackLengths[cardView.stack]++;
		
		cardView = [cardsDiamonds objectAtIndex:i];
		if (!cardView.inDeck)
			stackLengths[cardView.stack]++;
		
		cardView = [cardsClubs objectAtIndex:i];
		if (!cardView.inDeck)
			stackLengths[cardView.stack]++;
		
		cardView = [cardsHearts objectAtIndex:i];
		if (!cardView.inDeck)
			stackLengths[cardView.stack]++;
	}
	for (i=0; i<12; i++) {
		if (i < 7) {
#if DEBUG			
			if (m_stackLengths[i] != stackLengths[i]) {				
				//debugShow(@"The value in m_stackLengths and the amount of cards in the stack are not iquals");
				m_stackLengths[i] = stackLengths[i];
			}
#else
			m_stackLengths[i] = stackLengths[i];
#endif
		} else if (i == 7) {
#if DEBUG			
			if (m_dropLength != stackLengths[i]) {				
				//debugShow(@"The value in m_dropLength and the amount of cards in the stack are not iquals");
				m_dropLength = stackLengths[i];
			}
#else
			m_dropLength = stackLengths[i];
#endif
			
		} else {
#if DEBUG			
			if (m_aceStackLengths[i-8] != stackLengths[i]) {				
				//debugShow(@"The value in m_aceStackLengths and the amount of cards in the stack are not iquals");
				m_aceStackLengths[i-8] = stackLengths[i];
			}
#else
			m_aceStackLengths[i-8] = stackLengths[i];
#endif
			
		}
	}
}

// When a card is drop we have to validate the move
- (BOOL)manageDropCard:(CardView*)card {
	
	// We have to find the stack where the card was drop
	BOOL found = NO;
	int i = 0;
	
	int dragStack = card.stack;
	
	UIImageView *stackPanel;
	
	// Find which stack the dragged card is over, first go through each stack
	for (i=0; i<12; i++) {
		
		stackPanel = [self getStack:i];
		
		// If the card is over this stack
		if ([self isOverStack:stackPanel StackIndex:i CardCenter:card.center]) {
			
			if (i < 7) { // Stacks
				
				int stack = 0;
				int suit = 0;
				int flipped = 0;
				int cardValue = 0;
				stack = i;
				
				m_undoType = 1;
				m_undo[1][0] = dragStack;		// Set drag from
				m_undo[1][1] = stack;			// Set drag to
				m_undo[1][2] = m_dragLength;	// Set length
				// TODO: enabled undo
				
				if (m_stackLengths[stack] != 0) {
					suit = m_stacks[stack][0][m_stackLengths[stack]-1];
					cardValue = m_stacks[stack][1][m_stackLengths[stack]-1];
					flipped = m_stacks[stack][4][m_stackLengths[stack]-1];
				}
				
				// Drag stack
				int dSuit, dCardValue;
				
				dSuit = m_drag[0][0];
				dCardValue = m_drag[1][0];
				
				// Drop Card
				if ((dCardValue == 12 && m_stackLengths[stack] == 0) // King
					|| (flipped == 1 
						&& suit % 2 != dSuit % 2 
						&& dCardValue == cardValue -1)) { // Not flipped down, not same color, next card down
					// Drop cards on new stack
					int k = 0;
					int newY;
					while (k < m_dragLength) {
						
						dSuit = m_drag[0][k];
						dCardValue = m_drag[1][k];

						card = [self getCardFromStackSuit:dSuit CardValue:dCardValue];

						newY = 0;
						if (dCardValue != 12) {
							newY = m_stacks[stack][3][m_stackLengths[stack]-1] + m_large;
						}
						[self setCardStack:stack 
									  Suit:dSuit 
								 CardValue:dCardValue 
										 X:0 
										 Y:newY 
								   Flipped:1 
									 Index:m_stackLengths[stack]];
						m_stackLengths[stack]++;
						found = YES;
						k++;
						
						// Set card position
						card.frame = CGRectMake(stackPanel.frame.origin.x, 
												stackPanel.frame.origin.y + newY, 
												stackPanel.frame.size.width, 
												stackPanel.frame.size.height);
												
						[self bringSubviewToFront:card];

						// New stack
						card.stack = stack;
						card.inDeck = NO;
						card.inDropPanel = NO;
					}
					
					// Enabled the below card in the original stack if there is one
					[self enabledTopCardInStack:dragStack];
					
					// Scoring
					if (m_scoring == SCORING_STANDARD) {
						if (dragStack == 7) { // Drop panel
							m_score += 5;
						} else if (dragStack > 7) { // Ace panels
							m_score -= 15;
						}
						[self updateStatus];
					}
					break;
				}
			} else if (i > 7) { // Ace drop
				
				m_undoType = 1;
				m_undo[1][0] = dragStack;		// Set drag from
				m_undo[1][1] = i;				// Set drag to
				m_undo[1][2] = 1;				// Set length
				// TODO: enabled undo
				
				// Drag stack
				int dSuit, dCardValue;
				dSuit = m_drag[0][0];
				dCardValue = m_drag[1][0];
				
				// New stack
				int suit = 0;
				int cardValue = 0;
				int stack = 0;
				
				stack = i-8;
				
				if (m_aceStackLengths[stack] != 0) {
					suit = m_aceStacks[stack][0][m_aceStackLengths[stack]-1];
					cardValue = m_aceStacks[stack][1][m_aceStackLengths[stack]-1];
				}
				
				if ((m_aceStackLengths[stack] == 0	&& dCardValue == 0) // Ace
					|| (m_dragLength == 1 
						&& dSuit == suit
						&& dCardValue == cardValue + 1
						&& m_aceStackLengths[stack] > 0)) { // Not flipped down, same suit, next card down
					
					m_aceStacks[stack][0][m_aceStackLengths[stack]] = dSuit;
					m_aceStacks[stack][1][m_aceStackLengths[stack]] = dCardValue;
					m_aceStackLengths[stack]++;
					
					if (m_scoring == SCORING_STANDARD) {
						m_score += 10;
					} else if (m_scoring == SCORING_VEGAS || m_scoring == SCORING_VEGAS_CUMULATIVE) {
						m_score += 5;
					}
					if (m_scoring != SCORING_NONE) {
						[self updateStatus];
					}
					if (  m_aceStackLengths[0] 
						+ m_aceStackLengths[1] 
						+ m_aceStackLengths[2] 
						+ m_aceStackLengths[3] == 52) { // Win
						
						m_win = YES;
						[self stopTimer];
//#if DEBUG
						debugShow(@"Congratulations !!! You win");
//#endif
						toolbar.hidden = NO;
						
						// TODO: disable undo
					}

					found = YES;

					// Set card position
					card.frame = stackPanel.frame;

					// Enabled the below card in the original stack if there is one
					[self enabledTopCardInStack:dragStack];

					// New stack
					card.stack = stack + 8; // 8 to 11 ace stacks
					card.inDeck = NO;
					card.inDropPanel = NO;
					
					break;
				}
			}
		}   
	}
	
	if (!found) {
		
		if (dragStack > 7) { // Ace panels
			m_aceStackLengths[dragStack-8]++;
		} else if (dragStack == 7) { // Drop panel
			m_dropLength++;
		} else {
			m_stackLengths[dragStack] += m_dragLength;
		}
	
	}

	[self validateStackLengths];
	m_dragLength = 0;
	
	[self validateGame];
	
	return found;
}

- (BOOL)findHitStack:(int)stack Suit:(int)suit CardValue:(int)cardValue {
	int i = 0;
	int x, y; // TODO: probably not used
	BOOL found = NO;
	
	if (stack > 7) { // Aces
		if (m_aceStackLengths[stack-8] != 0) {
			found = YES;
			m_hitCard = m_aceStackLengths[stack-8] - 1;
		}
	} else if (stack == 7) { // Drop panel
		if (m_dropLength != 0) {
			if (!m_drawOne) { // TODO: understand why it is necesary
				x = m_drop[2][m_dropLength-1];
				y = m_drop[3][m_dropLength-1];
				m_hitCard = m_dropLength -1;
				found = YES;
				i++;
			} else {
				m_hitCard = m_dropLength -1;
				found = YES;
			}
		}
	} else { // Stacks
		while (i < m_stackLengths[stack] && !found) {
			if (suit == m_stacks[stack][0][i] && cardValue == m_stacks[stack][1][i]) {
				m_hitCard = i;
				found = YES;
			}
			i++;
		}
	}
	
	return found;
}

- (void)startDragCard:(CardView*)card {
	
	[self validateStackLengths];
	
	int stack;
	stack = card.stack;
	toolbar.hidden = YES;

	// Start timer if first move
	if (m_time == 0 && m_timedGame) {
		[self startTimer];
	}
	
	if ([self findHitStack:stack Suit:card.suit CardValue:card.cardValue]) {
				
		int j = 0;
		int i = m_hitCard;
		
		if (stack > 7) { // Aces
			m_drag[0][j] = m_aceStacks[stack-8][0][i]; // Copy suit
			m_drag[1][j] = m_aceStacks[stack-8][1][i]; // Copy card value
			m_drag[2][j] = 0; // Set y = 0
			m_dragLength = 1; // Set drag length to one card
			m_aceStackLengths[stack-8]--; // Make ace stack length one card smaller
			
		} else if (stack == 7) { // Drop panel
			m_drag[0][j] = m_drop[0][i]; // Copy suit
			m_drag[1][j] = m_drop[1][i]; // Copy card value
			m_drag[2][j] = 0; // Set y = 0
			m_dragLength = 1; // Set drag length to one card
			m_dropLength--; // Make drop length one card smaller
			
		} else { // Stack
			int y;
			y = m_stacks[stack][3][m_hitCard];
			while (i < m_stackLengths[stack]) {
				m_drag[0][j] = m_stacks[stack][0][i]; // Copy suit
				m_drag[1][j] = m_stacks[stack][1][i]; // Copy card value
				m_drag[2][j] = m_stacks[stack][3][i]-y; // Copy y (adjusting for offset)	
				i++;
				j++;
			}
			
			// Calculate length of drag array
			m_dragLength = m_stackLengths[stack] - m_hitCard;
			
			// Shorten stack
			m_stackLengths[stack] = m_hitCard;
		}
	}
}

- (void)managePickCard:(CardView*)card {
	int limit = 1;
	int i;
	
	if (m_deckLength > 0) {
		if (!m_drawOne) {
			limit = 3;
			if (m_deckLength < 3) {
				limit = m_deckLength;
			}
		}
		// Set undo information
		m_undo[0][0] = limit;
		m_undoType = 0;
		
		int undoCount = 0;
		if (m_dropLength > 0) {
			if (m_drop[3][m_dropLength-1] != 0) {
				undoCount++;
			}
		}
		if (m_dropLength > 1) {
			if (m_drop[3][m_dropLength-2] != 0) {
				undoCount++;
			}
		}
		m_undo[0][1] = undoCount;
		
		for (i=0; i<limit; i++) {
			int suit, cardValue;
			
			// Get card for card drop
			suit = m_deck[0][m_deckLength-1];
			cardValue = m_deck[1][m_deckLength-1];
			m_deckLength--;
			
			// Add card to m_drop array
			m_drop[0][m_dropLength] = suit;
			m_drop[1][m_dropLength] = cardValue;
			m_drop[2][m_dropLength] = i * m_xBigShift;
			m_drop[3][m_dropLength] = i * m_yShift;
			m_dropLength++;
			
			if (m_dropLength > 3 && m_drop[3][m_dropLength-3] != 0) {
				m_drop[2][m_dropLength-3] = 0;
				m_drop[3][m_dropLength-3] = 0;
			}
			if (m_dropLength > 4 && m_drop[3][m_dropLength-4] != 0) {
				m_drop[2][m_dropLength-4] = 0;
				m_drop[3][m_dropLength-4] = 0;
			}
		}
		
		// Start timer if first move
		if (m_time == 0 && m_timedGame) {
			[self startTimer];
		}
	} 
	if (m_deckLength < 1) {
		deckToDeal.userInteractionEnabled = YES;
	}
}

- (void)flipCard:(CardView*)card {
	int stack = card.stack;
	if (m_stackLengths[stack] > 0) {
		int suit = card.suit;
		int cardValue = card.cardValue;
		if (suit == m_stacks[stack][0][m_stackLengths[stack]-1] 
			&& cardValue == m_stacks[stack][1][m_stackLengths[stack]-1]) {
			m_stacks[stack][4][m_stackLengths[stack]-1] = 1;
		} else {
			// This is a bug, but if the m_stackLengths[stack]-2 is the card view
			// we can survive :)
			if (suit == m_stacks[stack][0][m_stackLengths[stack]-2] 
				&& cardValue == m_stacks[stack][1][m_stackLengths[stack]-2]) {
				// Fix the stack length
				m_stackLengths[stack]--;
				m_stacks[stack][4][m_stackLengths[stack]-1] = 1;
			} else {
#if DEBUG
				debugShow(@"flipCard was called but the card passed to it isn't the top card in the stack");
#endif
			}
		}
	}	
}

- (void)manageDoubleTap:(CardView*)card {

	// Start timer if first move
	if (m_time == 0 && m_timedGame) {
		[self startTimer];
	}
	
	if (!card.flipped || card.inDeck) {
		return;
	}
	
	int stack = card.stack;
	int suit = card.suit;
	int cardValue = card.cardValue;
	
	toolbar.hidden = YES;
	
	if (stack == 7) { // Drop panel
	
		if (m_drop[0][m_dropLength-1] != suit) return;
		if (m_drop[1][m_dropLength-1] != cardValue) return;
	
	} else if (stack < 7) {
	
		if (m_stacks[stack][0][m_stackLengths[stack]-1] != suit) return;
		if (m_stacks[stack][1][m_stackLengths[stack]-1] != cardValue) return;		
	}
	if (cardValue == 0) { // Ace
		int i = 0;
		while (i < 4) {
			if (m_aceStackLengths[i] == 0) {
				m_aceStacks[i][0][0] = suit;
				m_aceStacks[i][1][0] = cardValue;
				m_aceStackLengths[i]++;
				if (stack == 7) { // Drop panel
					m_dropLength--;
				} else { // Stacks
					m_stackLengths[stack]--;
				}

				// Set card position
				UIImageView *stackPanel;					
				stackPanel = [self getStack:i+8];
				card.frame = stackPanel.frame;
				
				// Enabled the below card in the original stack if there is one
				[self enabledTopCardInStack:stack];
				
				// Scoring
				if (m_scoring == SCORING_STANDARD) {
					m_score += 10;
				} else if (m_scoring == SCORING_VEGAS || m_scoring == SCORING_VEGAS_CUMULATIVE) {
					m_score += 5;
				}
				if (m_scoring != SCORING_NONE) {
					[self updateStatus];
				}
				m_undoType = 4;
				m_undo[4][0] = i;
				m_undo[4][1] = stack;
				// TODO: Enabled undo
				
				card.stack = i+8; // 8 to 11 ace stacks
				card.inDeck = NO;
				card.inDropPanel = NO;
				
				break;
			}
			i++;
		}
	} else { // Non ace
		int i = 0;
		while (i < 4) {
			if (m_aceStackLengths[i] != 0 
				&& m_aceStacks[i][0][m_aceStackLengths[i]-1] == suit
				&& m_aceStacks[i][1][m_aceStackLengths[i]-1] == cardValue -1) {
			
				m_aceStacks[i][0][m_aceStackLengths[i]] = suit;
				m_aceStacks[i][1][m_aceStackLengths[i]] = cardValue;
				m_aceStackLengths[i]++;
				if (stack == 7) {
					m_dropLength--;
				} else {
					m_stackLengths[stack]--;
				}
				
				// Set card position
				UIImageView *stackPanel;					
				stackPanel = [self getStack:i+8];
				card.frame = stackPanel.frame;

				// Enabled the below card in the original stack if there is one
				[self enabledTopCardInStack:stack];

				// Scoring
				if (m_scoring == SCORING_STANDARD) {
					m_score += 10;
				} else if (m_scoring == SCORING_VEGAS || m_scoring == SCORING_VEGAS_CUMULATIVE) {
					m_score += 5;
				}
				if (m_scoring != SCORING_NONE) {
					[self updateStatus];
				}
				m_undoType = 4;
				m_undo[4][0] = i;
				m_undo[4][1] = stack;
				// TODO: Enabled undo
				
				if (  m_aceStackLengths[0] 
					+ m_aceStackLengths[1] 
					+ m_aceStackLengths[2] 
					+ m_aceStackLengths[3] == 52) { // Win
					
					m_win = YES;
					[self stopTimer];
//#if DEBUG
					debugShow(@"Congratulations !!! You win");
//#endif
					// TODO: disable undo
				}		

				card.stack = i+8; // 8 to 11 ace stacks
				card.inDeck = NO;
				card.inDropPanel = NO;
				
				break;				
			}
			i++;
		}
	}
}

- (void)setStackZorder:(CardView*)card {
	int stack = card.stack;
	
	if (stack < 7) {
		BOOL found = NO;
		int i, suit, cardValue;

		for (i=0; i<m_stackLengths[stack]; i++) {
			suit = m_stacks[stack][0][i];
			cardValue = m_stacks[stack][1][i];
			if (found && suit != -1 && cardValue != -1) {
				card = [self getCardFromStackSuit:suit CardValue:cardValue];
				[self bringSubviewToFront:card];
			} else if (suit == card.suit && cardValue == card.cardValue) {
				found = YES;
			}
		}	
	}
}

- (BOOL)cardIsInDeck:(CardView*)card {
	if (card.stack != 0) {
		return NO;
	} else {
		CGPoint point = card.center;
		if(	  point.x >= deckToDeal.frame.origin.x
		   && point.y >= deckToDeal.frame.origin.y
		   && point.x <= deckToDeal.frame.origin.x + deckToDeal.frame.size.width
		   && point.y <= deckToDeal.frame.origin.y + deckToDeal.frame.size.height
		   ) {
			return YES;
		}
		else {
			return NO;
		}
	}
}

- (void)setCardPositionInDeck:(CardView*)card {
	card.center = deckToDeal.center;
}

- (CGPoint)getPositionInStack:(int)stack Suit:(int)suit CardValue:(int)cardValue {
	CGPoint stackCenter = [[self getStack:stack] center];
	for (int i=0; i<m_stackLengths[stack]; i++) {
		if (m_stacks[stack][0][i] == suit && m_stacks[stack][1][i] == cardValue) {
			stackCenter = CGPointMake(stackCenter.x, stackCenter.y + m_stacks[stack][3][i]);
			break;
		}
	}
	return stackCenter;
}

- (void)updateScoringType:(int)scoring {
	m_scoring = scoring;
}
/*
- (void)startTouch {
	m_bInTouch = YES;
}

- (BOOL)inTouch {
	return m_bInTouch;
}

- (void)endTouch {
	m_bInTouch = NO;
}
*/
@end
