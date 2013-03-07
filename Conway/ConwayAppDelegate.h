//
//  ConwayAppDelegate.h
//  Conway
//
//  Created by John Terracina on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LifeBoard.h"
#import "LifeView.h"

#define MIN_WIDTH 24
#define MIN_HEIGHT 24
#define MAX_WIDTH 128
#define MAX_HEIGHT 128

@interface ConwayAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSTimer *timer;
    bool    is_running;
    LifeBoard *theBoard;
    IBOutlet LifeView *gridView;
    IBOutlet NSTextField *widthNumBox;
    IBOutlet NSTextField *heightNumBox;
    IBOutlet NSTextField *generationNumLabel;
    IBOutlet NSSlider *speedSlider;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction) clearButtonPressed:(id) sender;
-(IBAction) startButtonPressed:(id) sender;
-(IBAction) stopButtonPressed:(id) sender;
-(IBAction) iterateButtonPressed:(id)sender;
-(IBAction) speedSliderMoved:(id)sender;
-(IBAction) widthEntered:(id)sender;
-(IBAction) heightEntered:(id)sender;

-(IBAction) changeBoardSize:(id)sender;

-(void) run_once;

@end
