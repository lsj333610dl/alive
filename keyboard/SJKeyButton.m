//
//  SJKeyButton.m
//  alive
//
//  Created by 이상진 on 2014. 12. 17..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import "SJKeyButton.h"

@implementation SJKeyButton

- (void)drawRect:(CGRect)rect{
    
    self.layer.cornerRadius = 7.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithWhite:0.1f alpha:1.0f].CGColor;
    self.layer.masksToBounds = YES;
}


-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
