//
//  CardView.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CardView.h"
#import "Solitaire.h"
#import "Debug.h"

// Import QuartzCore for animations
#import <QuartzCore/QuartzCore.h>


@implementation CardView

@synthesize cardImage;
@synthesize inDeck;
@synthesize inDropPanel;
@synthesize flipped;
@synthesize stack;
@synthesize suit;
@synthesize cardValue;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        // Initialization code
		self.userInteractionEnabled = YES;
    }
    return self;	
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
	if (cardImage != nil) {
		[cardImage release];
	}
    [super dealloc];
}


- (void)animateViewToCenter {
	
	// Bounces the placard back to the center
	Solitaire *solitaire = (Solitaire*)self.superview;
	m_location = [solitaire getPositionInStack:self.stack Suit:self.suit CardValue:self.cardValue];
	
	CALayer *welcomeLayer = self.layer;
	
	// Create a keyframe animation to follow a path back to the center
	CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	bounceAnimation.removedOnCompletion = NO;
	
	CGFloat animationDuration = 1.5;
	
	
	// Create the path for the bounces
	CGMutablePathRef thePath = CGPathCreateMutable();
	
	CGFloat midX = m_location.x;
	CGFloat midY = m_location.y;
	CGFloat originalOffsetX = self.center.x - midX;
	CGFloat originalOffsetY = self.center.y - midY;
	CGFloat offsetDivider = 4.0;
	
	BOOL stopBouncing = NO;
	
	// Start the path at the placard's current location
	CGPathMoveToPoint(thePath, NULL, self.center.x, self.center.y);
	CGPathAddLineToPoint(thePath, NULL, midX, midY);
	
	// Add to the bounce path in decreasing excursions from the center
	while (stopBouncing != YES) {
		CGPathAddLineToPoint(thePath, NULL, midX + originalOffsetX/offsetDivider, midY + originalOffsetY/offsetDivider);
		CGPathAddLineToPoint(thePath, NULL, midX, midY);
		
		offsetDivider += 4;
		animationDuration += 1/offsetDivider;
		if ((abs(originalOffsetX/offsetDivider) < 6) && (abs(originalOffsetY/offsetDivider) < 6)) {
			stopBouncing = YES;
		}
	}
	
	bounceAnimation.path = thePath;
	bounceAnimation.duration = animationDuration;
	CGPathRelease(thePath);
	
	// Create a basic animation to restore the size of the placard
	CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnimation.removedOnCompletion = YES;
	transformAnimation.duration = animationDuration;
	transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	
	
	// Create an animation group to combine the keyframe and basic animations
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
	
	// Set self as the delegate to allow for a callback to reenable user interaction
	theGroup.delegate = self;
	theGroup.duration = animationDuration;
	theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
	theGroup.animations = [NSArray arrayWithObjects:bounceAnimation, transformAnimation, nil];
	
	
	// Add the animation group to the layer
	[welcomeLayer addAnimation:theGroup forKey:@"animatePlacardViewToCenter"];
	
	// Set the placard view's center and transformation to the original values in preparation for the end of the animation
	self.center = m_location;
	self.transform = CGAffineTransformIdentity;
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	//Animation delegate method called when the animation's finished:
	// restore the transform and reenable user interaction
	self.transform = CGAffineTransformIdentity;
	self.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = [touch tapCount];

	Solitaire *solitaire = (Solitaire*)self.superview;

	switch (tapCount) {
		case 1:
			
			/*
			if ([solitaire inTouch]) {
				return;
			} else {
				[solitaire startTouch];
			}
			 */
			
			// To manage double tap bug
			m_bOneTouch = YES;
			
			if (inDeck && !self.flipped) {
				
				self.frame = CGRectMake(DROP_PANEL_LEFT, DROP_PANEL_TOP, self.frame.size.width, self.frame.size.height);
				self.image = cardImage;
				self.flipped = YES;
				self.inDeck = NO;
				self.inDropPanel = YES;
				
				[solitaire bringSubviewToFront:self];
				[solitaire managePickCard:self];
				[solitaire setTopCardInDeck:self];
				
			} else {
								
				if (!self.flipped) {
					self.image = cardImage;
					self.flipped = YES;		
					[solitaire flipCard:self];
				}
				
				[self.superview bringSubviewToFront:self];
			}
			
			break;

		case 2:
			
			// To manage double tap bug
			if (!m_bOneTouch) { return; }
			
			if (![solitaire cardIsInDeck:self]) {
				[solitaire manageDoubleTap:self];
			}
			break;
			
		default:
			break;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if (!m_bFirstCallToMoved) {
		m_bFirstCallToMoved = YES;
		m_location = self.center;    
		Solitaire *solitaire = (Solitaire*)self.superview;
		[solitaire startDragCard:self];
	}
	
	// If the touch was in the placardView, move the placardView to its location
	if ([touch view] == self) {
		CGPoint location = [touch locationInView:[self superview]];
		self.center = location;		
		return;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	m_bFirstCallToMoved = NO;

	// To manage double tap bug
	if (m_location.x == 0 && m_location.y == 0) { return; }
	
	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = [touch tapCount];
	
	if (tapCount == 2) { 
		return;
	}
	
	if (self.center.x != m_location.x || self.center.y != m_location.y) {

		Solitaire *solitaire = (Solitaire*)self.superview;
				
		if([solitaire cardIsInDeck:self]) {
			[solitaire setCardPositionInDeck:self];
		} else if (![solitaire manageDropCard:self]) {
			// Disable user interaction so subsequent touches don't interfere with animation
			self.userInteractionEnabled = NO;
			[self animateViewToCenter];
			// TODO: set zorder in this stack
			[solitaire setStackZorder:self];
		}		
	}
	
	//[solitaire endTouch];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	// Null implementation
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

-(void) resetCard {
	inDeck = NO;
	inDropPanel = NO;
	flipped = NO;
	stack = 0;
	suit = 0;
	cardValue = 0;
	m_bFirstCallToMoved = NO;
	m_bOneTouch = NO;
}

@end
