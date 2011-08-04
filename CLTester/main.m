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
    
    LifeBoard * life = [[LifeBoard alloc] initWithWidth:20 andHeight:10];
    
    [life printBoard];
    [life flipCellX:5 Y:0];
    [life flipCellX:5 Y:1];
    [life flipCellX:5 Y:2];
    
    [life printBoard];
    [life iterate];
    [life printBoard];
    
    
    
    [life dealloc];
    [pool drain];
    return 0;
}

