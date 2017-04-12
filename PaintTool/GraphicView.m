//
//  GraphicView.m
//  PaintTool
//
//  Created by Rony on 17/4/11.
//  Copyright © 2017年 Rony. All rights reserved.
//

#import "GraphicView.h"

@implementation GraphicView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
   
    // Drawing code
    if ((!self.points) || (self.points.count < 2)) {
        return;
    }
    
    context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    //设置画笔粗细
    CGContextSetLineWidth(context, 1.0f);
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, paint_clr);
    
    //画以前的轨迹
    for (int j = 0 ; j < [self.points_all count]; j++) {
        NSMutableArray *points_tmp = [_points_all objectAtIndex:j];
        
        for (int i = 0;i < [points_tmp count]-1;i++)
        {
            NSValue *pt1value=[points_tmp objectAtIndex:i];
            NSValue *pt2value=[points_tmp objectAtIndex:i+1];
            
            NSPoint point1 = [pt1value pointValue];
            NSPoint point2 = [pt2value pointValue];

            CGContextMoveToPoint(context, point1.x, point1.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextStrokePath(context);
        }
    }
    
    //画这次
    for (int i=0; i < [self.points count]-1; i++) {
        NSValue *pt1value=[_points objectAtIndex:i];
        NSValue *pt2value=[_points objectAtIndex:i+1];
        
        NSPoint point1 = [pt1value pointValue];
        NSPoint point2 = [pt2value pointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }

}

-(void)mouseDown:(NSEvent *)event
{
    self.points=[NSMutableArray array];
    NSPoint pt=[event locationInWindow];
    [self.points addObject:[NSValue valueWithPoint:pt]];
}


-(void)mouseDragged:(NSEvent *)event
{
    NSPoint pt = [event locationInWindow];
    [self.points addObject:[NSValue valueWithPoint:pt]];
    NSLog(@"move to x=%.3f,y=%.3f\n",pt.x,pt.y);
    [self setNeedsDisplay:YES];
}


-(void)mouseUp:(NSEvent *)event
{
    NSMutableArray *points_tmp = [[NSMutableArray alloc] initWithArray:self.points];
    if (self.points_all == nil) {
        self.points_all = [[NSArray alloc] initWithObjects:points_tmp, nil];
    }else {
        self.points_all = [self.points_all arrayByAddingObject:points_tmp];
    }
    
}

-(IBAction)set:(id)sender
{
    paint_clr=[clrwell.color CGColor];
    [self setNeedsDisplay:YES];
}


@end
