//
//  DelegationSplitViewWindowController.m
//  AutoLayoutTest
//
//  Created by Bill So on 11/7/14.
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

#import "DelegationSplitViewWindowController.h"

#define UH_LEFT_PANE_MINIMUM		200.0
#define UH_MIDDLE_PANE_MINIMUM		320.0
#define UH_RIGHT_PANE_MINIMUM		240.0

@interface DelegationSplitViewWindowController () {
	CGFloat fullMinimumWidth;
}

@end

@implementation DelegationSplitViewWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
	
	fullMinimumWidth = UH_LEFT_PANE_MINIMUM + UH_MIDDLE_PANE_MINIMUM + UH_RIGHT_PANE_MINIMUM + _innerSplitView.dividerThickness + _outerSplitView.dividerThickness;
	
//	[_outerSplitView setPosition:0.0 ofDividerAtIndex:0];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (CGFloat)currentMinimumWidth {
	CGFloat curMin = fullMinimumWidth;
	if ( [_outerSplitView isSubviewCollapsed:_projectListContainerView] ) {
		curMin -= UH_LEFT_PANE_MINIMUM;
	}
	if ( [_innerSplitView isSubviewCollapsed:_messageContainerView] ) {
		curMin -= UH_RIGHT_PANE_MINIMUM;
	}
	return curMin;
}

#pragma mark NSWindowDelegate

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize {
	CGFloat minWidth = [self currentMinimumWidth];
	if ( ![_outerSplitView isSubviewCollapsed:_projectListContainerView] ) {
		// make sure the width is not smaller than current minimum width
		// find the difference proposed size and current size
		if ( sender.frame.size.width - frameSize.width > UH_LEFT_PANE_MINIMUM / 2.0 ) {
			// we should collapse the left pane
			[_outerSplitView setPosition:0.0 ofDividerAtIndex:0];
			// don't modify frameSize. So, we return the current proposed size
		} else {
			if ( frameSize.width < minWidth ) {
				frameSize.width = minWidth;
			}
		}
	} else if (![_innerSplitView isSubviewCollapsed:_messageContainerView] ) {
		// current size == current minimum width
		if ( sender.frame.size.width == minWidth ) {
			// check if the proposed width is less then half the width of minimum right width
			if ( sender.frame.size.width - frameSize.width > UH_RIGHT_PANE_MINIMUM / 2.0 ) {
				// collapse the right pane
				[_innerSplitView setPosition:_innerSplitView.bounds.size.width ofDividerAtIndex:0];
			}
		} else if ( frameSize.width < minWidth ) {
			frameSize.width = minWidth;
		}
	}
	return frameSize;
}

#pragma mark NSSplitViewDelegate

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
	return subview == _projectListContainerView;
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view {
	return YES;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
	if ( splitView == _outerSplitView ) {
		return UH_LEFT_PANE_MINIMUM;
	} else {
		return UH_MIDDLE_PANE_MINIMUM;
	}
	return proposedMinimumPosition;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
	if ( splitView == _outerSplitView && dividerIndex == 0 ) {
		// can't be bigger than the min size of both message and composer view
		return splitView.bounds.size.width - ( UH_MIDDLE_PANE_MINIMUM + UH_RIGHT_PANE_MINIMUM + splitView.dividerThickness + splitView.dividerThickness );
	} else if ( splitView == _innerSplitView && dividerIndex == 0 ) {
		return splitView.bounds.size.width - UH_RIGHT_PANE_MINIMUM - splitView.dividerThickness;
	}
	return proposedMaximumPosition;
}

@end
