//
//  KeyboardViewController.m
//  keyboard
//
//  Created by 상진 이 on 2014. 12. 15..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import "KeyboardViewController.h"
#import "SJKeyboard.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (strong, nonatomic) SJKeyboard *keyboard;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isShift;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isShift = NO;
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"SJKeyboard" owner:nil options:nil] firstObject];
    self.inputView = _keyboard;
    [self setPrimaryLanguage:@"ko"];
    
    
    for (UIButton *key in _keyboard.keys) {
        [key addTarget:self action:@selector(key:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_keyboard.backspaceKey addTarget:self action:@selector(backword) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_keyboard.shiftKey addTarget:self action:@selector(shift) forControlEvents:UIControlEventTouchUpInside];
    
    [_keyboard.spaceKey addTarget:self action:@selector(space) forControlEvents:UIControlEventTouchUpInside];
    
    [_keyboard.enterKey addTarget:self action:@selector(returnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    [_keyboard.nextKeyboardKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(backwordLong:)];
    [_keyboard.backspaceKey addGestureRecognizer:longPressGR];
    
    return;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}


#pragma mark - keySelectors

- (void)key:(UIButton*)key{
    [self.textDocumentProxy insertText:[[key.titleLabel.text decomposedStringWithCompatibilityMapping]precomposedStringWithCompatibilityMapping]];
    
    if (_isShift) {
        [self shift];
    }
}

- (void)backword{
    [self.textDocumentProxy deleteBackward];
}

- (void)backwordLong:(UILongPressGestureRecognizer*)lpgr{
    
    
    if ( lpgr.state != UIGestureRecognizerStateEnded ) {
        if (_timer != nil) {
            return;
        }
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(backword) userInfo:nil repeats:YES];
    }
    
    else {
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)shift{
    if (!_isShift) {
        [UIView setAnimationsEnabled:NO];
        for (UIButton* key in _keyboard.keys) {
            [key setTitle:[key.titleLabel.text uppercaseString] forState:UIControlStateNormal];
        }
        [_keyboard.shiftKey setBackgroundColor:[UIColor darkGrayColor]];
        
        [UIView setAnimationsEnabled:YES];
        _isShift = YES;
    }
    
    else {
        
        [UIView setAnimationsEnabled:NO];
        for (UIButton* key in _keyboard.keys) {
            [key setTitle:[key.titleLabel.text lowercaseString] forState:UIControlStateNormal];
        }
        
        [_keyboard.shiftKey setBackgroundColor:[UIColor colorWithWhite:0.17f alpha:1.0f]];
        
        [UIView setAnimationsEnabled:YES];
        _isShift = NO;
    }
    
}

- (void)numKeyboard{
    
}

- (void)space{
    [self.textDocumentProxy insertText:@" "];
}

- (void)returnSelector{
    [self.textDocumentProxy insertText:@"\n"];
}





@end
