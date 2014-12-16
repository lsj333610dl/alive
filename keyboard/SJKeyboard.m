//
//  SJKeyboard.m
//  alive
//
//  Created by 상진 이 on 2014. 12. 15..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import "SJKeyboard.h"

@implementation SJKeyboard

- (void)drawRect:(CGRect)rect{
    
    
    [UIView animateWithDuration:2.0f
                     animations:^{
                         
                         _bgView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
                     }
     
                     completion:^(BOOL finished){
                     
                         [UIView animateWithDuration:2.0f
                                          animations:^{
                                              
                                              _bgView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
                                          } completion:^(BOOL finished){
                                              [self drawRect:self.frame];
                                          }];
                         
                     }];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
