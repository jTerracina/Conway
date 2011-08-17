//
//  main.m
//  CLTester
//
//  Created by John Terracina on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LifeBoard.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // insert code here...
    NSLog(@"Hello, World!");
    
    IntArray2D *testArray = [[IntArray2D alloc] initWithWidth:10 andHeight:4];
   
    [testArray setValue:5 atX:4 andY:1];
    [testArray printArray];
    
    LifeBoard *testBoard = [[LifeBoard alloc] initWithWidth:40 andHeight:20];
    
    [testBoard flipCellX:4 Y:10];
    [testBoard flipCellX:4 Y:11];
    [testBoard flipCellX:4 Y:12];
    [testBoard flipCellX:4 Y:13];
    [testBoard flipCellX:5 Y:14];
    [testBoard flipCellX:4 Y:14];
    [testBoard flipCellX:5 Y:15];
    [testBoard printBoard];
    
    int i;
    for (i=0; i<100; i++){
        [testBoard iterate];
        [testBoard printBoard];
    }
    
    
    [testArray dealloc];
    [pool drain];
    return 0;
}

