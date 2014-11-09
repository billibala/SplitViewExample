//
//  DelegationSplitViewWindowController.h
//  AutoLayoutTest
//
//  Created by Bill So on 11/7/14.
//  Copyright (c) 2014 Bill So. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DelegationSplitViewWindowController : NSWindowController <NSSplitViewDelegate>

@property (nonatomic, weak) IBOutlet NSView *projectListContainerView;
@property (nonatomic, weak) IBOutlet NSView *contentListContainerView;
@property (nonatomic, weak) IBOutlet NSView *messageContainerView;
@property (nonatomic, weak) IBOutlet NSSplitView *outerSplitView;
@property (nonatomic, weak) IBOutlet NSSplitView *innerSplitView;

@end
