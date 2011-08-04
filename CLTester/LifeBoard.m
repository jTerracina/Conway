//
//  LifeBoard.m
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeBoard.h"

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
    board = malloc(sizeof(int*)*width);
    int i;
    for (i = 0; i < width; i++)
    {
        board[i] = malloc(sizeof(int)*h);
    }
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
            if (board[i][j] == 0)
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
            board[i][j] = 0;
        }
}

-(void) flipCellX:(int)x Y:(int)y
{
    if (board[y][x] == 0){board[y][x] = 1;}
    else {board[y][x] = 0;}
    
}

-(void) turnCellOnX:(int)x Y:(int)y
{
    board[y][x] = 1;
}

-(void) turnCellOffX:(int)x Y:(int)y
{
    board[y][x] = 0;
}

-(int) cellAtX:(int)x Y:(int)y
{
    return board[y][x];
}

-(void) iterate
{
    int x,y;
    int** newboard;
    newboard = malloc(sizeof(int*)*width);
    for (x = 0; x < width; x++)
    {
        newboard[x] = malloc(sizeof(int)*height);
    }
    
    for (x = 0; x < width; x++)
    {
        for (y=0; y<height; y++)
        {
            int nsum = [self neighborSumAtX:x Y:y];
            if ([self cellAtX:x Y:y] == 1){
                if ((nsum<2)||(nsum>3))
                {
                    newboard[y][x]=0;
                }
                else{
                    newboard[y][x]=1;
                }
            }
            else
            {
                if (nsum == 3)
                {
                    newboard[y][x]=1;
                }
                else{
                    newboard[y][x]=0;
                }
            }
        }
    }
    //free(board);
    board = newboard;
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
    //int i;
    //for (i = 0; i < width; i++){
    //    free(board[i]);
    //}
    free(board);
    
    [super dealloc];
}
@end










