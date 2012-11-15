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
    BFAlienCellBackgroundViewPosition position;
    CGGradientRef alienGradient;
}

@property(nonatomic, retain) UIColor *borderColor, *fillColor;
@property(nonatomic) BFAlienCellBackgroundViewPosition position;
@end