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

board_point board_pointAtXAndY(int x, int y);

@interface BoardPoint : NSObject{
    int x;
    int y;
}
-(id) initWithX:(int) xx andY:(int) yy;
+(BoardPoint *) boardPointWithX:(int) x andY:(int) y;
@property(readonly) int x;
@property(readonly) int y;

@end

@interface IntArray2D : NSObject {
@protected
    unsigned int height;
    unsigned int width;
    int * array;
}
@property(readonly) unsigned int width;
@property(readonly) unsigned int height;

-(id) initWithWidth:(int) setWidth andHeight:(int)setHeight;
-(int) valueAtX:(int)x andY:(int)y;//to be deprecated
-(int) valueAtPoint:(BoardPoint *) pt;
-(void) setValue:(int)value atX:(int)x andY:(int)y;//to be deprecated
-(void) setValue:(int)value atPoint:(BoardPoint *) pt;
-(void) printArray;

@end

@interface IntArray2D_wrap : IntArray2D{
}
-(int) valueAtPoint:(BoardPoint *)pt;
-(int) valueAtX:(int)x andY:(int)y;//to be deprecated
@end

@interface LifeBoard : NSObject
{    
    int height;
    int width;
    IntArray2D_wrap *board;
    NSMutableArray * changedPoints;
}
@property(readonly) int height;
@property(readonly) int width;
@property(readonly) NSMutableArray * changedPoints;

-(id) initWithWidth:(int) w andHeight:(int) h;
-(void) resizeBoardWithWidth:(int) w andHeight:(int) h;
-(void) nonDestructiveResizeBoardWithWidth:(int) w andHeight:(int) h;
-(void) printBoard;
-(void) zeroOutBoard;
-(void) flipCellX:(int)x Y:(int)y;
-(void) turnCellOnX:(int)x Y:(int)y;
-(void) turnCellOffX:(int)x Y:(int)y;
-(int) cellAtX:(int)x Y:(int)y;
-(void) iterate;
-(int) neighborSumAtX:(int)x Y:(int)y;
-(void) changesApplied;//clears changedPoints. Call after drawing.
@end
