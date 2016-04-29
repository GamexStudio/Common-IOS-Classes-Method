//
//  MyTextFIeld.m
//  mRupee
//
//  Created by Abhishek Kumar on 25/11/15.
//  Copyright © 2015 TTH. All rights reserved.
//

#import "MyTextFIeld.h"

@implementation MyTextFIeld

- (void)drawRect:(CGRect)rect {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}


- (void) drawPlaceholderInRect:(CGRect)rect {
    [[UIColor whiteColor] setFill];
    
    
    UIColor *colour = [UIColor lightGrayColor];
    UIFont *font = [UIFont systemFontOfSize:17];

    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: colour,
                                 NSFontAttributeName:font};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];

  //  [self.placeholder drawInRect:rect withAttributes:attributes];
    
   
    
    
   
}


@end
