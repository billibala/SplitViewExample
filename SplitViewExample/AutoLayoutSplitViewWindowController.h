//
//  AutoLayoutSplitViewWindowController.h
//  AutoLayoutTest
//
//  Created by Bill So on 11/8/14.
//  Copyright (c) 2014 Bill So. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainSplitView.h"

@interface AutoLayoutSplitViewWindowController : NSWindowController <NSSplitViewDelegate>

@property (weak) IBOutlet MainSplitView * splitView;
@property (weak) IBOutlet NSView *leftPane;
@property (weak) IBOutlet NSLayoutConstraint *leftPaneWidthConstraint;

- (IBAction)toggleLeftPane:(id)sender;

@end
