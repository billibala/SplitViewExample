//
//  MainSplitView.m
//  AutoLayoutTest
//
//  Created by Bill So on 11/4/14.
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Bill So
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
