//
//  LifeBoard.m
//  Conway
//
//  Created by John Terracina on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeBoard.h"

board_point board_pointAtXAndY(int x, int y){
    board_point pt;
    pt.x = x;
    pt.y = y;
    return pt;
}

@implementation BoardPoint
@synthesize x;
@synthesize y;

-(id) initWithX:(int)xx andY:(int)yy{
    self = [super init];
    x = xx;
    y = yy;
    return self;
}
+(BoardPoint *) boardPointWithX:(int)xx andY:(int)yy{
    BoardPoint * bp = [[BoardPoint alloc] initWithX:xx andY:yy];
    return bp;
}

@end

@implementation IntArray2D
@synthesize width;
@synthesize height;
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

-(int) valueAtPoint:(BoardPoint *)pt{
    if (pt.x >= 0 && pt.x < width && pt.y >= 0 && pt.y < height){
        return array[pt.y*width+pt.x];
    }
    else{
        return 0;
    }
}

-(int) valueAtX:(int)x andY:(int)y{
    if (x >= 0 && x < width && y >= 0 && y < height){
        return array[y*width+x];
    }
    else{
        return 0;
    }
}

-(void) setValue:(int)value atPoint:(BoardPoint *)pt{
    if (pt.x >= 0 && pt.x < width && pt.y >= 0 && pt.y < height){
        array[pt.y*width+pt.x]= value;
    }
}

-(void) setValue:(int)value atX:(int)x andY:(int)y
{
    if (x >= 0 && x < width && y >= 0 && y < height){
        array[y*width+x]= value;
    }
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

@implementation IntArray2D_wrap
-(int) valueAtPoint:(BoardPoint *)pt{
    int xx = pt.x;
    int yy = pt.y;
    while (xx < 0){xx += width;}
    while (yy < 0){yy += height;}
    return array[(yy%height)*width + (xx%width)];
        
}
-(int) valueAtX:(int)x andY:(int)y{
    int xx = x;
    int yy = y;
    while (xx < 0){xx += width;}
    while (yy < 0){yy += height;}
    return array[(yy%height)*width + (xx%width)];
}


@end




@implementation LifeBoard
@synthesize height;
@synthesize width;
@synthesize changedPoints;
- (id)init
{
    //should never be called directly
    self = [super init];
    if (self) {
        self = [self initWithWidth:24 andHeight:24];
    }
    
    return self;
}

-(id) initWithWidth:(int)w andHeight:(int)h
{
    self = [super init];
    height = h;
    width = w;
    board = [[IntArray2D_wrap alloc] initWithWidth:width andHeight:height];
    changedPoints = [[NSMutableArray alloc]initWithCapacity:(w*h)];
    [self zeroOutBoard];
    return self;
}

-(void) resizeBoardWithWidth:(int)w andHeight:(int)h {
    [board dealloc];
    height = h;
    width = w;
    board = [[IntArray2D_wrap alloc] initWithWidth:w andHeight:h];
    [self zeroOutBoard];
    
}

-(void) nonDestructiveResizeBoardWithWidth:(int)w andHeight:(int)h{
    IntArray2D_wrap * newBoard = [[IntArray2D_wrap alloc] initWithWidth:w andHeight:h];
    int i, j = 0;
    for (i = 0; i < w; i++){
        for (j = 0; j < h; j++){
            [newBoard setValue:0 atPoint:[BoardPoint boardPointWithX:i andY:j]];
        }
    }
    for (i = 0; i < board.width; i++){
        for (j = 0; j < board.height; j++){
            BoardPoint * pt = [BoardPoint boardPointWithX:i andY:j];
            [newBoard setValue:[board valueAtPoint:pt] atPoint:pt];
        }
    }
    [board dealloc];
    height = h;
    width = w;
    board = newBoard;
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
            [changedPoints addObject:[BoardPoint boardPointWithX:i andY:j]];
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
    [changedPoints addObject:[BoardPoint boardPointWithX:x andY:y]];
    
}

-(void) turnCellOnX:(int)x Y:(int)y
{
    [board setValue:1 atX:x andY:y];
    [changedPoints addObject:[BoardPoint boardPointWithX:x andY:y]];
}

-(void) turnCellOffX:(int)x Y:(int)y
{
    [board setValue:0 atX:x andY:y];
    [changedPoints addObject:[BoardPoint boardPointWithX:x andY:y]];
}

-(int) cellAtX:(int)x Y:(int)y
{
    return [board valueAtX:x andY:y];
}

-(void) iterate
{
    int x,y;
    IntArray2D_wrap *newboard = [[IntArray2D_wrap alloc] initWithWidth:width andHeight:height];
    
    
    for (x=0; x < width; x++)
    {
        for (y=0; y<height; y++)
        {
            int nsum = [self neighborSumAtX:x Y:y];
            if ([self cellAtX:x Y:y] == 1){
                if ((nsum<2)||(nsum>3))
                {
                    [newboard setValue:0 atX:x andY:y];
                    [changedPoints addObject:[BoardPoint boardPointWithX:x andY:y]];
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
                    [changedPoints addObject:[BoardPoint boardPointWithX:x andY:y]];
                }
                else{
                    [newboard setValue:0 atX:x andY:y];
                }
            }
        }
    }
    IntArray2D_wrap *tmp = board;
    board = newboard;
    [tmp dealloc];
}

-(int) neighborSumAtX:(int)x Y:(int)y 
{
    int sum = 0;
    if ((x> -1)&&(y>-1))           {sum += [self cellAtX:x-1 Y:y-1];}
    if (y>-1)                    {sum += [self cellAtX:x Y:y-1];}
    if ((x<width+1)&&(y>-1))       {sum += [self cellAtX:x+1 Y:y-1];}
    if (x>-1)                    {sum += [self cellAtX:x-1 Y:y];}
    if (x<width+1)                {sum += [self cellAtX:x+1 Y:y];}
    if ((x>-1)&&(y<height+1))      {sum += [self cellAtX:x-1 Y:y+1];}
    if (y<height+1)               {sum += [self cellAtX:x Y:y+1];}
    if ((x<width+1)&&(y<height+1))  {sum += [self cellAtX:x+1 Y:y+1];}
    return sum;
}

-(void) changesApplied{
    [changedPoints removeAllObjects];
}

-(void) dealloc
{
    [BoardPoint dealloc];
    [board dealloc];
    [super dealloc];
}
@end










