//
//  AutoLayoutSplitViewWindowController.m
//  AutoLayoutTest
//
//  Created by Bill So on 11/8/14.
//  Copyright (c) 2014 Bill So. All rights reserved.
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
