//
//  LifeBoard.m
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeBoard.h"

@implementation IntArray2D

-(id) initWithWidth:(int)setWidth andHeight:(int)setHeight
{
    /*
    array stored as:
     1, 2, 3, 4
     5, 6, 7, 8
     9, 10, 11, 12
     
     so access as array[y*width+x]
     
    */
    self = [super init];
    width = setWidth;
    height = setHeight;
    array = malloc(sizeof(int)*width*height);
    unsigned int i;
    for (i = 0; i < width*height; i++){
        array[i] = 0;
    }
    
    return self;
}

-(int) valueAtX:(int)x andY:(int)y{
    return array[y*width+x];
}

-(void) setValue:(int)value atX:(int)x andY:(int)y
{
    array[y*width+x]= value;
}

-(void) printArray
{
    int i,j;
    printf("A 2d array of width:%i and height:%i\n",width,height);
    for (i=0; i<height; i++){
        for (j=0; j<width; j++){
            printf("%i ",[self valueAtX:j andY:i]);
        }
        printf("\n");
    }
}

-(void) dealloc{
    free(array);
    [super dealloc];
}

@end






@implementation LifeBoard

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id) initWithWidth:(int)w andHeight:(int)h
{
    self = [self init];
    height = h;
    width = w;
    board = [[IntArray2D alloc] initWithWidth:width andHeight:height];
    
    [self zeroOutBoard];
    return self;
}


-(void) printBoard
{
    int i = 0;
    int j = 0;
    printf("%%Conway's Game of Life%%\n");
    for (i = 0; i < height; i++)
    {
        for (j = 0; j < width; j++)
        {
            if ([board valueAtX:j andY:i] == 0)
                printf("_");
            else
                printf("@");
                
        }
        printf("\n");
    }
}

-(void) zeroOutBoard
{
    int i,j;
    for (i = 0; i < height; i ++)
        for (j = 0; j < width; j++)
        {
            [board setValue:0 atX:j andY:i];
        }
    
}

-(void) flipCellX:(int)x Y:(int)y
{
    if ([board valueAtX:x andY:y] == 0)
    {
        [board setValue:1 atX:x andY:y];
    }
    else if ([board valueAtX:x andY:y] == 1)
    {
        [board setValue:0 atX:x andY:y];
    }
    
}

-(void) turnCellOnX:(int)x Y:(int)y
{
    [board setValue:1 atX:x andY:y];
}

-(void) turnCellOffX:(int)x Y:(int)y
{
    [board setValue:0 atX:x andY:y];
}

-(int) cellAtX:(int)x Y:(int)y
{
    return [board valueAtX:x andY:y];
}

-(void) iterate
{
    int x,y;
    IntArray2D *newboard = [[IntArray2D alloc] initWithWidth:width andHeight:height];
    
    
    for (x=0; x < width; x++)
    {
        for (y=0; y<height; y++)
        {
            int nsum = [self neighborSumAtX:x Y:y];
            if ([self cellAtX:x Y:y] == 1){
                if ((nsum<2)||(nsum>3))
                {
                    [newboard setValue:0 atX:x andY:y];
                }
                else{
                    [newboard setValue:1 atX:x andY:y];
                }
            }
            else
            {
                if (nsum == 3)
                {
                    [newboard setValue:1 atX:x andY:y];
                }
                else{
                    [newboard setValue:0 atX:x andY:y];
                }
            }
        }
    }
    IntArray2D *tmp = board;
    board = newboard;
    [tmp dealloc];
}

-(int) neighborSumAtX:(int)x Y:(int)y 
{
    int sum = 0;
    if ((x>0)&&(y>0))           {sum += [self cellAtX:x-1 Y:y-1];}
    if (y>0)                    {sum += [self cellAtX:x Y:y-1];}
    if ((x<width)&&(y>0))       {sum += [self cellAtX:x+1 Y:y-1];}
    if (x>0)                    {sum += [self cellAtX:x-1 Y:y];}
    if (x<width)                {sum += [self cellAtX:x+1 Y:y];}
    if ((x>0)&&(y<height))      {sum += [self cellAtX:x-1 Y:y+1];}
    if (y<height)               {sum += [self cellAtX:x Y:y+1];}
    if ((x<width)&&(y<height))  {sum += [self cellAtX:x+1 Y:y+1];}
    return sum;
}
-(void) dealloc
{
    
    [board dealloc];
    [super dealloc];
}
@end










