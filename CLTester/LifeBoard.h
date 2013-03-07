//
//  LifeBoard.h
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
    int x;
    int y;
}board_point;

@interface IntArray2D : NSObject {
@protected
    unsigned int height;
    unsigned int width;
    int * array;
}

-(id) initWithWidth:(int) setWidth andHeight:(int)setHeight;
-(int) valueAtX:(int)x andY:(int)y;
-(void) setValue:(int)value atX:(int)x andY:(int)y;
-(void) printArray;

@end

@interface IntArray2D_wrap : IntArray2D{
}
-(int) valueAtX:(int)x andY:(int)y;
@end

@interface LifeBoard : NSObject
{    
    int height;
    int width;
    IntArray2D_wrap *board;
}
@property(readonly) int height;
@property(readonly) int width;

-(id) initWithWidth:(int) w andHeight:(int) h;
-(void) resizeBoardWithWidth:(int) w andHeight:(int) h;
-(void) printBoard;
-(void) zeroOutBoard;
-(void) flipCellX:(int)x Y:(int)y;
-(void) turnCellOnX:(int)x Y:(int)y;
-(void) turnCellOffX:(int)x Y:(int)y;
-(int) cellAtX:(int)x Y:(int)y;
-(void) iterate;
-(int) neighborSumAtX:(int)x Y:(int)y;
@end
