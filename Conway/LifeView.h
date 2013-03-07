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
    CGFloat margin;
    LifeBoard * board;
    board_point current_cell;

}

-(void) setLifeBoard:(LifeBoard*)theBoard;
-(void) refreshView;
-(board_point) NSPoint2board_point:(NSPoint)thePoint;

@end
