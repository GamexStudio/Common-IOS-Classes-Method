//
//  TextField_Dropdown.m
//  RPG
//
//  Created by Ashish Chauhan on 14/04/16.
//  Copyright © 2016 Ashish Chauhan. All rights reserved.
//

#import "TextField_Dropdown.h"

@implementation TextField_Dropdown


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor blackColor].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
}


@end
