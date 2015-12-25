//
//  OptionsDialog.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OptionsDialog.h"

#define kLeftMargin				20.0
#define kTopMargin				60.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0

#define kSegmentedControlHeight 40.0
#define kLabelHeight			20.0


@implementation OptionsDialog

+ (UILabel*)labelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    
	label.textAlignment = UITextAlignmentLeft;
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
	
    return label;
}

- (void)createControls
{
	// TODO: 3 Cards
	/*
	NSArray *drawStyleContent = [NSArray arrayWithObjects: @"Draw One", @"Draw Three", nil];
	
	// label
	CGFloat yPlacement = kTopMargin;
	CGRect frame = CGRectMake(kLeftMargin, yPlacement, self.bounds.size.width - (kRightMargin * 2.0), kLabelHeight);
	[self addSubview:[OptionsDialog labelWithFrame:frame title:@"Draw:"]];
			
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:drawStyleContent];
	yPlacement += kTweenMargin + kLabelHeight;
	frame = CGRectMake(	kLeftMargin,
					   yPlacement,
					   self.bounds.size.width - (kRightMargin * 2.0),
					   kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;	
	segmentedControl.tintColor = [UIColor colorWithRed:0.171 green:0.70 blue:0.1 alpha:1.0];
	segmentedControl.selectedSegmentIndex = 1;
	
	[self addSubview:segmentedControl];
	[segmentedControl release];
	 */
	// TODO: 3 Cards end

	NSArray *scoringStyleContent = [NSArray arrayWithObjects: @"Standard", @"Vegas", @"Vegas cumulative", nil];

	// label
	CGFloat yPlacement = kTopMargin;
	yPlacement += (kTweenMargin * 2.0) + kSegmentedControlHeight;
	CGRect frame = CGRectMake(	kLeftMargin,
					   yPlacement,
					   self.bounds.size.width,
					   kLabelHeight);
	[self addSubview:[OptionsDialog labelWithFrame:frame title:@"Scoring"]];
	
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:scoringStyleContent];
	yPlacement += kTweenMargin + kLabelHeight;
	frame = CGRectMake(	kLeftMargin,
					   yPlacement,
					   self.bounds.size.width - (kRightMargin * 2.0),
					   kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;	
	segmentedControl.tintColor = [UIColor colorWithRed:0.171 green:0.70 blue:0.1 alpha:1.0];
	segmentedControl.selectedSegmentIndex = 0;
	
	[self addSubview:segmentedControl];
	[segmentedControl release];
	
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code

		// Table top
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
		[self addSubview:imageView];
		[imageView release];

		// Toolbar
		UIToolbar *toolbar = [[UIToolbar alloc] init];
		[toolbar sizeToFit];
		CGFloat toolbarHeight = [toolbar frame].size.height;
		CGRect rootViewBounds = self.bounds;
		CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
		CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
		CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
		[toolbar setFrame:rectArea];
		
		UIBarButtonItem *dealButton = [[UIBarButtonItem alloc]
									   initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(hideView)];
				
		[toolbar setItems:[NSArray arrayWithObjects:dealButton,nil]];
		
		toolbar.barStyle = UIBarStyleBlack;
		toolbar.tintColor = [UIColor blackColor]; 
		toolbar.translucent = YES;
				
		//Add the toolbar as a subview to the navigation controller.
		[self addSubview:toolbar];
		[toolbar release];
		
		/*
		UIView *view;
		UIButton *button;
		
		view = [[UIView alloc] initWithFrame:CGRectMake(0,0,480,40)];
		view.backgroundColor = [UIColor blackColor];
		
		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	    button.frame = CGRectMake(10,5,60,30);
		[button setTitle:@"Done" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
		[view addSubview:button];
		//[button release];
	
		[self addSubview:view];
		[view release];
		*/ 
	
		self.backgroundColor = [UIColor colorWithRed:0.2 green:1.0 blue:0.6 alpha:1.0];
		
		[self createControls];
				
    }
    return self;
}

- (void)segmentAction:(id)sender
{
	//NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
	if ([sender selectedSegmentIndex] == 0) {
		m_scoring = SCORING_VEGAS;
	} else if ([sender selectedSegmentIndex] == 1) {
		m_scoring = SCORING_VEGAS;
	} else {
		m_scoring = SCORING_VEGAS_CUMULATIVE;
	}
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    [super dealloc];
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
	
	[solitaire updateScoringType:m_scoring];
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_DECK];
	view.hidden = YES;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_OPTIONS];
	view.hidden = YES;
	
	view = [[[self superview] subviews] objectAtIndex:VIEW_SOLITAIRE];
	view.hidden = NO;
	
}

@end
