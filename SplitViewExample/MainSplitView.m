//
//  MainSplitView.m
//  AutoLayoutTest
//
//  Created by Bill So on 11/4/14.
//  Copyright (c) 2014 Bill So. All rights reserved.
//

#import "MainSplitView.h"

@implementation MainSplitView

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    // Drawing code here.
//}

- (void)addConstraints:(NSArray *)constraints {
	if ( constraints.count == 1 ) {
		NSLayoutConstraint * theConstraint = constraints.firstObject;
		
		if ( theConstraint.firstItem == self.subviews.lastObject && theConstraint.firstAttribute == NSLayoutAttributeLeft && theConstraint.secondItem == self && theConstraint.secondAttribute == NSLayoutAttributeLeft ) {
			// make sure the constraint has low priority
			theConstraint.priority = NSLayoutPriorityDefaultLow;
			[super addConstraints:@[theConstraint]];
		} else if ( theConstraint.firstItem == self.subviews.firstObject && theConstraint.firstAttribute == NSLayoutAttributeRight && theConstraint.secondItem == self && theConstraint.secondAttribute == NSLayoutAttributeLeft ) {
			theConstraint.priority = NSLayoutPriorityDefaultLow;
			[super addConstraints:@[theConstraint]];
		} else {
			[super addConstraints:constraints];
		}
	} else {
		[super addConstraints:constraints];
	}
}

@end
