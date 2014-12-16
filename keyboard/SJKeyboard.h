//
//  SJKeyboard.h
//  alive
//
//  Created by 상진 이 on 2014. 12. 15..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJKeyboard : UIInputView
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *keys;
@property (strong, nonatomic) IBOutlet UIButton *backspaceKey;
@property (strong, nonatomic) IBOutlet UIButton *enterKey;
@property (strong, nonatomic) IBOutlet UIButton *shiftKey;
@property (strong, nonatomic) IBOutlet UIButton *spaceKey;
@property (strong, nonatomic) IBOutlet UIButton *nextKeyboardKey;
@property (strong, nonatomic) IBOutlet UIButton *numberKeyboardKey;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
