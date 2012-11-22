//
//  BFAlienCellBackgroundView.m
//  BFAlienTableView
//
//  Created by Dario Lencina on 11/11/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "BFAlienCellBackgroundView.h"
#define ROUND_SIZE 10
static NSMutableDictionary * _cachedRenders;

@implementation BFAlienCellBackgroundView

@synthesize borderColor, fillColor, position;

#pragma mark -
#pragma mark initialization

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(!_cachedRenders){
        _cachedRenders=[NSMutableDictionary new];
    }
    return self;
}

-(BOOL)isOpaque {
    return NO;
}

-(BOOL)clearsContextBeforeDrawing{
    return NO;
}

#pragma mark -
#pragma mark CoreGraphics Image Drawing.

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

-(NSString *)keyForRect:(CGRect)rect andPosition:(BFAlienCellBackgroundViewPosition)viewPosition{
    return [NSString stringWithFormat:@"%@ %d", NSStringFromCGRect(rect), (NSInteger)viewPosition];
}

-(void)drawOuterCanvasInRect:(CGRect)rect withTopPositionInContext:(CGContextRef)ctx {
    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    minx = minx + 1;
    miny = miny + 1;
    
    maxx = maxx - 1;
    maxy = maxy ;
    
    CGContextMoveToPoint(ctx, minx, maxy);
    CGContextAddArcToPoint(ctx, minx, miny, midx, miny, ROUND_SIZE);
    CGContextAddArcToPoint(ctx, maxx, miny, maxx, maxy, ROUND_SIZE);
    CGContextAddLineToPoint(ctx, maxx, maxy);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

-(void)drawOuterCanvasInRect:(CGRect)rect withMiddlePositionInContext:(CGContextRef)ctx {
    CGFloat minx = CGRectGetMinX(rect) , maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    minx = minx + 1;
    miny = miny ;
    
    maxx = maxx - 1;
    maxy = maxy ;
    
    CGContextMoveToPoint(ctx, minx, miny);
    CGContextAddLineToPoint(ctx, maxx, miny);
    CGContextAddLineToPoint(ctx, maxx, maxy);
    CGContextAddLineToPoint(ctx, minx, maxy);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

-(void)drawOuterCanvasInRect:(CGRect)rect withBottomPositionInContext:(CGContextRef)ctx {
    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    minx = minx + 1;
    miny = miny ;
    
    maxx = maxx - 1;
    maxy = maxy - 1;
    
    CGContextMoveToPoint(ctx, minx, miny);
    CGContextAddArcToPoint(ctx, minx, maxy, midx, maxy, ROUND_SIZE);
    CGContextAddArcToPoint(ctx, maxx, maxy, maxx, miny, ROUND_SIZE);
    CGContextAddLineToPoint(ctx, maxx, miny);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

-(void)drawOuterCanvasInRect:(CGRect)rect withSinglePositionInContext:(CGContextRef)ctx {
    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    CGFloat midy = CGRectGetMidY(rect);
    
    CGContextMoveToPoint(ctx, minx, midy);
    CGContextAddArcToPoint(ctx, minx, miny, midx, miny, ROUND_SIZE);
    CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, ROUND_SIZE);
    CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, ROUND_SIZE);
    CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, ROUND_SIZE);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

-(CGImageRef)backgroundImageForRect:(CGRect)rect andPosition:(BFAlienCellBackgroundViewPosition)viewPosition{
    NSString * key=[self keyForRect:rect andPosition:viewPosition];
    UIImage * cachedRender=[_cachedRenders objectForKey:key];
    if(!cachedRender){
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale) ;
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGAffineTransform flipVertical = CGAffineTransformMake(
                                                               1, 0, 0, -1, 0, rect.size.height
                                                               );
        CGContextConcatCTM(c, flipVertical);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithRed:0.22 green:0.27 blue:0.54 alpha:1] CGColor]);
        CGContextSetStrokeColorWithColor(c, [[UIColor clearColor] CGColor]);
        if(alienGradient==NULL)
            [self CreateAlienGradient:&alienGradient];
        if (position == BFAlienCellBackgroundViewPositionTop) {
            [self drawOuterCanvasInRect:rect withTopPositionInContext:c];
        } else if (position == BFAlienCellBackgroundViewPositionBottom) {
            [self drawOuterCanvasInRect:rect withBottomPositionInContext:c];
        } else if (position == BFAlienCellBackgroundViewPositionMiddle) {
            [self drawOuterCanvasInRect:rect withMiddlePositionInContext:c];
        }else if(position==BFAlienCellBackgroundViewPositionSingle){
            [self drawOuterCanvasInRect:rect withSinglePositionInContext:c];
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
        CGContextSetShadow(c, CGSizeMake(0,-4), 6);
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
        cachedRender= UIGraphicsGetImageFromCurrentImageContext();
        [_cachedRenders setObject:cachedRender forKey:key];
        UIGraphicsEndImageContext();
    }
    return [cachedRender CGImage];
}

#pragma mark -
#pragma mark CoreGraphicsViewDrawing

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGImageRef img=[self backgroundImageForRect:rect andPosition:position];
    CGContextRef viewContext = UIGraphicsGetCurrentContext();
    CGContextDrawImage(viewContext, rect, img);
}


@end
