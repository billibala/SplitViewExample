//
//  AutoLayoutSplitViewWindowController.m
//  AutoLayoutTest
//
//  Created by Bill So on 11/8/14.
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

#import "AutoLayoutSplitViewWindowController.h"

@interface AutoLayoutSplitViewWindowController ()

@end

@implementation AutoLayoutSplitViewWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)toggleLeftPane:(id)sender {
	// get frame
	NSRect winFrame = self.window.frame;
	// lower content holding priority and width constraint priority of the left pane so that it's the first subview to get resized
	_leftPaneWidthConstraint.priority = 1;
	[_splitView setHoldingPriority:1 forSubviewAtIndex:0];
	
	CGFloat width = _leftPane.bounds.size.width;
	BOOL leftPaneCollapsed = [_splitView isSubviewCollapsed:_leftPane] || _leftPane.isHidden || _leftPane.bounds.size.width == 0.0;
	// refer to WWDC 2013 sessoin 213 for explanation - http://asciiwwdc.com/2013/sessions/213 44:00
	// the code below is implemented with reference to the talk. It's not exactly the same though (namely, I added "setHidden")
	if ( leftPaneCollapsed ) {
		// we need to show the left pane
		[_leftPane setHidden:NO];
		// really update the size of the window to accomodate the width of project list
		winFrame.origin.x -= _leftPaneWidthConstraint.constant, winFrame.size.width += _leftPaneWidthConstraint.constant;
		[self.window setFrame:winFrame display:YES animate:YES];
	} else {
		// hide the project list
		winFrame.origin.x += width, winFrame.size.width -= width;
		[self.window setFrame:winFrame display:YES animate:YES];
		// set pane hidden so ths
		[_leftPane setHidden:YES];
	}
	// restore the priority
	_leftPaneWidthConstraint.priority = NSLayoutPriorityDefaultHigh;
	[_splitView setHoldingPriority:NSLayoutPriorityDefaultLow - 1 forSubviewAtIndex:0];
}

#pragma mark NSSplitViewDelegate

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
	return subview == _leftPane;
}

@end
