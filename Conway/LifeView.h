//
//  LifeView.h
//  Conway
//
//  Created by John Terracina on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LifeBoard.h"



@interface LifeView : NSView
{
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat rectWidth;
    CGFloat rectHeight;
    CGFloat margin;
    LifeBoard * board;
    board_point current_cell;
    bool needs_redraw;

}

-(void) setLifeBoard:(LifeBoard*)theBoard;

-(void) drawCell;
-(board_point) NSPoint2board_point:(NSPoint)thePoint;

@end
