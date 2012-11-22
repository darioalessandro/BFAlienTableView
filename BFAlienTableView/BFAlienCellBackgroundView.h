//
//  BFAlienCellBackgroundView.h
//  BFAlienTableView
//
//  Created by Dario Lencina on 11/11/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

typedef enum  {
    BFAlienCellBackgroundViewPositionTop,
    BFAlienCellBackgroundViewPositionMiddle,
    BFAlienCellBackgroundViewPositionBottom,
    BFAlienCellBackgroundViewPositionSingle
} BFAlienCellBackgroundViewPosition;

@interface BFAlienCellBackgroundView : UIView {
    UIColor *borderColor;
    UIColor *fillColor;
    CGGradientRef alienGradient;
    BFAlienCellBackgroundViewPosition _position;
}
-(void)setPosition:(BFAlienCellBackgroundViewPosition)newPosition;
@property(nonatomic, retain) UIColor *borderColor, *fillColor;
@end