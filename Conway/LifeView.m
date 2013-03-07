//
//  LifeView.m
//  Conway
//
//  Created by John Terracina on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeView.h"

@implementation LifeView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        board = NULL;
    }
    margin = 10.0;

    return self;
}

-(void)setLifeBoard:(LifeBoard *)theBoard{
    
    board = theBoard;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [NSGraphicsContext saveGraphicsState];
    if (board == NULL){
        NSRect bkgdrect = CGRectInset([self bounds], 5, 5);
        NSBezierPath *bkgd = [NSBezierPath bezierPathWithRoundedRect:bkgdrect xRadius:5 yRadius:5];
        [[NSColor redColor] set];
        [bkgd fill];
    }
    else {
        [self refreshView];
    }
  
        
    
    
    
    [NSGraphicsContext restoreGraphicsState];
}

-(void) refreshView
{
    [NSGraphicsContext saveGraphicsState];
    [self lockFocus];
    
    
    [[NSColor blackColor] set];
    NSRect bkgdrect = CGRectInset([self bounds], 0, 0);
    NSBezierPath *bkgd = [NSBezierPath bezierPathWithRoundedRect:bkgdrect xRadius:5 yRadius:5];
    [bkgd fill];
    
    
    int row, col;
    CGFloat viewWidth = [self bounds].size.width - margin;
    CGFloat viewHeight = [self bounds].size.height - margin;
    CGFloat rectWidth = viewWidth/(board.width);
    CGFloat rectHeight = viewHeight/(board.height);
    NSRect rectTemplate = CGRectMake(1.5, 1.5, rectWidth-3,  rectHeight-3);
    for (row=0; row < board.width; row++)
    {
        for (col=0; col<board.height; col++)
        {
            NSRect rectToDraw = CGRectOffset(rectTemplate, row*rectWidth +margin/2, col*rectHeight + margin/2 );
            //NSLog(@"%f %f %f %f", rectToDraw.origin.x, rectToDraw.origin.y, rectToDraw.size.width, rectToDraw.size.height);
            NSBezierPath *pathOfRect = [NSBezierPath bezierPathWithRect:rectToDraw];
            if ([board cellAtX:row Y:col] == 1){[[NSColor blueColor] set];}
            else {[[NSColor whiteColor] set];}
            [pathOfRect fill];
            [pathOfRect stroke];
            
        }
    }
    [self setNeedsDisplay:YES];
    [self unlockFocus];
    [NSGraphicsContext restoreGraphicsState];
}

-(void) mouseDown:(NSEvent *)mouseDownEvent{
    NSPoint clickedon = [self convertPoint:mouseDownEvent.locationInWindow fromView:nil];
    
    board_point clicked_point = [self NSPoint2board_point:clickedon];
    [board flipCellX:clicked_point.x Y:clicked_point.y];
    
    current_cell = clicked_point;
    [self setNeedsDisplay:YES];
}

-(void) mouseDragged:(NSEvent *)theEvent {
    NSPoint draggedon = [self convertPoint:theEvent.locationInWindow fromView:nil];
    board_point dragged_point = [self NSPoint2board_point:draggedon];
    if (dragged_point.x != current_cell.x || dragged_point.y != current_cell.y){
        current_cell = dragged_point;
        [board flipCellX:dragged_point.x Y:dragged_point.y];
        [self setNeedsDisplay:YES];
    }
    
}


-(void) mouseUp:(NSEvent *)theEvent{
    current_cell.x = -99;
    current_cell.y = -99;
}

-(board_point)NSPoint2board_point:(NSPoint)thePoint{
    board_point pt;
    //set as Class constants?
    CGFloat rectWidth = ([self bounds].size.width - margin)/board.width;
    CGFloat rectHeight = ([self bounds].size.height - margin)/board.height;
    
    pt.x = (int)floor((thePoint.x - margin/2)/(rectWidth));
    pt.y = (int)floor((thePoint.y - margin/2)/(rectHeight));
    
    return pt;
}

@end
