//
//  ConwayAppDelegate.m
//  Conway
//
//  Created by John Terracina on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConwayAppDelegate.h"

@implementation ConwayAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    theBoard = [[LifeBoard alloc] initWithWidth:24 andHeight:24];
    [gridView setLifeBoard:theBoard];
    
    [gridView refreshView];
    [widthNumBox setIntValue:theBoard.width];
    [heightNumBox setIntValue:theBoard.height];
    
    
    double minDelay = 1.0/20.0; //20 fps
    double maxDelay = 0.5;
    double slideValue = minDelay + maxDelay * (([speedSlider maxValue] - [speedSlider doubleValue])/[speedSlider maxValue]);
    timer = [NSTimer scheduledTimerWithTimeInterval:slideValue target:self selector:@selector(run_once) userInfo:nil repeats:TRUE];
    
}

- (void) run_once{
    if (is_running){
        [theBoard iterate];
        [gridView refreshView];
        [generationNumLabel setIntValue:[generationNumLabel intValue]+1];
    }
}


-(IBAction) changeBoardSize:(id) sender{
    [theBoard resizeBoardWithWidth:[widthNumBox intValue] andHeight:[heightNumBox intValue]];
    [gridView refreshView];
}

-(IBAction)clearButtonPressed:(id)sender{
    [self stopButtonPressed:sender];
    [theBoard zeroOutBoard];
    [generationNumLabel setIntValue:0];
    [gridView refreshView];
}
-(IBAction)startButtonPressed:(id)sender{
    is_running = true;
}
-(IBAction)stopButtonPressed:(id)sender{
    is_running = false;
}
-(IBAction)iterateButtonPressed:(id)sender{
    [theBoard iterate];
    [generationNumLabel setIntValue:[generationNumLabel intValue]+1];
    [gridView refreshView];
}
-(IBAction)speedSliderMoved:(id)sender{
    double minDelay = 1.0/20.0; //20 fps
    double maxDelay = 0.5;
    double slideValue = minDelay + maxDelay * (([sender maxValue] - [sender doubleValue])/[sender maxValue]);
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:slideValue target:self selector:@selector(run_once) userInfo:nil repeats:TRUE];
}

-(IBAction)widthEntered:(id)sender{
    int newValue = [sender intValue];
    if (newValue > MAX_WIDTH){
        newValue = MAX_WIDTH;
    }
    if (newValue < MIN_WIDTH) {
        newValue = MIN_WIDTH;
    }
    [widthNumBox setIntValue:newValue];
}

-(IBAction)heightEntered:(id)sender{
    int newValue = [sender intValue];
    if (newValue > MAX_HEIGHT){
        newValue = MAX_HEIGHT;
    }
    if (newValue < MIN_HEIGHT) {
        newValue = MIN_HEIGHT;
    }
    [heightNumBox setIntValue:newValue];
}

@end
