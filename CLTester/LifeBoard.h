//
//  LifeBoard.h
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeBoard : NSObject
{    
    int height;
    int width;
    int** board;
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
