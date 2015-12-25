//
//  CardStack.m
//  Solitaire
//
//  Created by Javier Alvarez on 10/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CardStack.h"
#import "Solitaire.h"

@implementation CardStack

@synthesize isDeckToDeal;

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
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (isDeckToDeal) {
		Solitaire *solitaire = (Solitaire*)self.superview;
		[solitaire reloadDeckToDeal];
	}
}

@end
