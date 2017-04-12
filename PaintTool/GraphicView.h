//
//  GraphicView.h
//  PaintTool
//
//  Created by Rony on 17/4/11.
//  Copyright © 2017年 Rony. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GraphicView : NSView


{
    CGContextRef context;
    CGColorRef paint_clr;
    IBOutlet NSColorWell *clrwell;
    
}


@property (strong,nonatomic) NSMutableArray *points;
@property (strong,nonatomic) NSArray *points_all;

-(IBAction)set:(id)sender;

@end
