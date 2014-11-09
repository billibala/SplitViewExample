//
//  AppDelegate.m
//  SplitViewExample
//
//  Created by Bill So on 11/9/14.
//  Copyright (c) 2014 Bill So. All rights reserved.
//

#import "AppDelegate.h"
#import "DelegationSplitViewWindowController.h"
#import "AutoLayoutSplitViewWindowController.h"

@interface AppDelegate ()

@property (strong, nonatomic) DelegationSplitViewWindowController * otherWindowController;
@property (strong, nonatomic) AutoLayoutSplitViewWindowController * autoLayoutWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_otherWindowController = [[DelegationSplitViewWindowController alloc] initWithWindowNibName:@"DelegationSplitViewWindowController"];
	[_otherWindowController showWindow:nil];
	
	_autoLayoutWindowController = [[AutoLayoutSplitViewWindowController alloc] initWithWindowNibName:@"AutoLayoutSplitViewWindowController"];
	[_autoLayoutWindowController showWindow:nil];
	[_autoLayoutWindowController.window makeMainWindow];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

@end
