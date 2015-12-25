//
//  CardBackDialog.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CardBackDialog.h"


@implementation CardBackDialog

@synthesize cardBack;

+ (UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    
	label.textAlignment = UITextAlignmentLeft;
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
	
    return label;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		UIImageView *imageView;

		// Table top
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
		[self addSubview:imageView];
		[imageView release];

		// label
		[self addSubview:[CardBackDialog labelWithFrame:CGRectMake(15, 10, 400, 60) title:@"Select Card Back"]];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback1.png"]];
		imageView.frame = CGRectMake(5, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback2.png"]];
		imageView.frame = CGRectMake(5, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback3.png"]];
		imageView.frame = CGRectMake(85, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback4.png"]];
		imageView.frame = CGRectMake(85, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback5.png"]];
		imageView.frame = CGRectMake(165, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback6.png"]];
		imageView.frame = CGRectMake(165, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback7.png"]];
		imageView.frame = CGRectMake(245, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback8.png"]];
		imageView.frame = CGRectMake(245, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback9.png"]];
		imageView.frame = CGRectMake(325, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback10.png"]];
		imageView.frame = CGRectMake(325, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];

		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback11.png"]];
		imageView.frame = CGRectMake(405, 80, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardback12.png"]];
		imageView.frame = CGRectMake(405, 200, imageView.frame.size.width, imageView.frame.size.height);
		[self addSubview:imageView];
		[imageView release];
		
		self.backgroundColor = [UIColor colorWithRed:0.2 green:1.0 blue:0.6 alpha:1.0];
		 
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];

	if ([self containsPoint:location cardPosX:5 cardPosY:80]) {
		self.cardBack = BACK_CARD_01;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:5 cardPosY:200]) {
		self.cardBack = BACK_CARD_02;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:85 cardPosY:80]) {
		self.cardBack = BACK_CARD_03;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:85 cardPosY:200]) {
		self.cardBack = BACK_CARD_04;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:165 cardPosY:80]) {
		self.cardBack = BACK_CARD_05;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:165 cardPosY:200]) {
		self.cardBack = BACK_CARD_06;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:245 cardPosY:80]) {
		self.cardBack = BACK_CARD_07;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:245 cardPosY:200]) {
		self.cardBack = BACK_CARD_08;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:325 cardPosY:80]) {
		self.cardBack = BACK_CARD_09;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:325 cardPosY:200]) {
		self.cardBack = BACK_CARD_10;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:405 cardPosY:80]) {
		self.cardBack = BACK_CARD_11;
		[self hideView];
	}
	else if ([self containsPoint:location cardPosX:405 cardPosY:200]) {
		self.cardBack = BACK_CARD_12;
		[self hideView];
	}
}

-(BOOL)containsPoint:(CGPoint)point cardPosX:(int)x cardPosY:(int)y {
	
	if(	  point.x >= x
	   && point.y >= y
	   && point.x <= (70 + x)
	   && point.y <= (110 + y)
	   ) {
		return YES;
	}
	else {
		return NO;
	}
}

- (void)hideView {

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

	Solitaire *solitaire = [[[self superview] subviews] objectAtIndex:VIEW_SOLITAIRE];
	
	[solitaire updateCardBackImage:self.cardBack];
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_DECK];
	view.hidden = YES;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_OPTIONS];
	view.hidden = YES;

	solitaire.hidden = NO;

}

@end
