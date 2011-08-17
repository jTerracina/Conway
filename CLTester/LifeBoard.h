//
//  LifeBoard.h
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntArray2D : NSObject {
@private
    unsigned int height;
    unsigned int width;
    int * array;
}

-(id) initWithWidth:(int) setWidth andHeight:(int)setHeight;
-(int) valueAtX:(int)x andY:(int)y;
-(void) setValue:(int)value atX:(int)x andY:(int)y;
-(void) printArray;

@end


@interface LifeBoard : NSObject
{    
    int height;
    int width;
    IntArray2D *board;
}

-(id) initWithWidth:(int) w andHeight:(int) h;
-(void) printBoard;
-(void) zeroOutBoard;
-(void) flipCellX:(int)x Y:(int)y;
-(void) turnCellOnX:(int)x Y:(int)y;
-(void) turnCellOffX:(int)x Y:(int)y;
-(int) cellAtX:(int)x Y:(int)y;
-(void) iterate;
-(int) neighborSumAtX:(int)x Y:(int)y;
@end
