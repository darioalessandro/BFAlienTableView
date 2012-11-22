//
//  ViewController.m
//  BFAlienTableView
//
//  Created by Dario Lencina on 11/11/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "ViewController.h"
#import "BFAlienCellBackgroundView.h"

@interface ViewController ()

@end

@implementation ViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellStr= @"cell";
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        [cell setContentMode:UIViewContentModeRedraw];
        [cell setClipsToBounds:TRUE];
    }
    
    if(![[cell backgroundView] isMemberOfClass:[BFAlienCellBackgroundView class]]){
        BFAlienCellBackgroundView * view= [[BFAlienCellBackgroundView alloc] initWithFrame:cell.frame];
        [cell setBackgroundView:view];
    }
    
    BFAlienCellBackgroundViewPosition position;
    if(indexPath.row==0){
        position=BFAlienCellBackgroundViewPositionTop;
    }else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1){
        position=BFAlienCellBackgroundViewPositionBottom;
    }else{
        position=BFAlienCellBackgroundViewPositionMiddle;
    }
    [(BFAlienCellBackgroundView *)cell.backgroundView setPosition:position];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    for(UITableViewCell * cell in [self.tableView visibleCells]){
        [[cell backgroundView] setNeedsDisplay];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
@end
