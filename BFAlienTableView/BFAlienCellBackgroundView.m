//
//  BFAlienCellBackgroundView.m
//  BFAlienTableView
//
//  Created by Dario Lencina on 11/11/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "BFAlienCellBackgroundView.h"
#define ROUND_SIZE 10
@implementation BFAlienCellBackgroundView

@synthesize borderColor, fillColor, position;

- (BOOL) isOpaque {
    return NO;
}

-(BOOL)clearsContextBeforeDrawing{
    return NO;
}

-(void)CreateAlienGradient:(CGGradientRef *)gradient{
    size_t num_locations = 4;
    CGFloat locations[4] = { 0.0, 0.03, 0.85, 1.0 };
    CGFloat components[16] = {0.08, 0.07, 0.26, 1,  // Start color
                              0.22,	0.27, 0.54, 1,
                              0.32,	0.45, 0.69, 1,
                              1.00, 1.00, 1.00, 1}; // End color
    
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    *gradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(c, [[UIColor colorWithRed:0.22 green:0.27 blue:0.54 alpha:1] CGColor]);
    CGContextSetStrokeColorWithColor(c, [[UIColor clearColor] CGColor]);
    if(alienGradient==NULL)
        [self CreateAlienGradient:&alienGradient];
    if (position == BFAlienCellBackgroundViewPositionTop) {
        
    	CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny + 1;
        
    	maxx = maxx - 1;
    	maxy = maxy ;
        
    	CGContextMoveToPoint(c, minx, maxy);
    	CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
    	CGContextAddArcToPoint(c, maxx, miny, maxx, maxy, ROUND_SIZE);
    	CGContextAddLineToPoint(c, maxx, maxy);
    	CGContextClosePath(c);
    	CGContextDrawPath(c, kCGPathFillStroke);
    } else if (position == BFAlienCellBackgroundViewPositionBottom) {
        
    	CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny ;
        
    	maxx = maxx - 1;
    	maxy = maxy - 1;
        
    	CGContextMoveToPoint(c, minx, miny);
    	CGContextAddArcToPoint(c, minx, maxy, midx, maxy, ROUND_SIZE);
    	CGContextAddArcToPoint(c, maxx, maxy, maxx, miny, ROUND_SIZE);
    	CGContextAddLineToPoint(c, maxx, miny);
    	CGContextClosePath(c);
    	CGContextDrawPath(c, kCGPathFillStroke);
    } else if (position == BFAlienCellBackgroundViewPositionMiddle) {
        CGFloat minx = CGRectGetMinX(rect) , maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny ;
        
    	maxx = maxx - 1;
    	maxy = maxy ;
        
    	CGContextMoveToPoint(c, minx, miny);
    	CGContextAddLineToPoint(c, maxx, miny);
    	CGContextAddLineToPoint(c, maxx, maxy);
    	CGContextAddLineToPoint(c, minx, maxy);
        CGContextClosePath(c);
    	CGContextDrawPath(c, kCGPathFillStroke);
    }else if(position==BFAlienCellBackgroundViewPositionSingle){
        CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
        CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
        CGFloat midy = CGRectGetMidY(rect);
        
        CGContextMoveToPoint(c, minx, midy);
        CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
        CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
        CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
        CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
        CGContextClosePath(c);
        CGContextDrawPath(c, kCGPathFillStroke);
    }
    
    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    CGFloat midy = CGRectGetMidY(rect);
    
    minx=minx+10;
    miny=miny+10;
    midx=midx-10;
    maxx=maxx-10;
    maxy=maxy-10;
    
    CGContextMoveToPoint(c, minx, midy);
    CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
    CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
    CGContextClosePath(c);
    
    CGContextSetStrokeColorWithColor(c, [UIColor clearColor].CGColor);
    CGContextSetShadow(c, CGSizeMake(0,4), 6);
    CGContextDrawPath(c, kCGPathFillStroke);
    
    CGContextMoveToPoint(c, minx, midy);
    CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
    CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
    CGContextClosePath(c);
    CGContextClip(c);
    CGContextDrawLinearGradient(c, alienGradient, CGPointMake(midx, maxy), CGPointMake(midx, 0), kCGGradientDrawsAfterEndLocation);

    CGContextDrawPath(c, kCGPathFillStroke);
    

}


@end
