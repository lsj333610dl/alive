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
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"SJKeyboard" owner:nil options:nil] firstObject];
    self.inputView = _keyboard;
    [self setPrimaryLanguage:@"ko"];
    
    
    for (UIButton *key in _keyboard.keys) {
        [key addTarget:self action:@selector(key:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_keyboard.backspaceKey addTarget:self action:@selector(backword) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_keyboard.spaceKey addTarget:self action:@selector(space) forControlEvents:UIControlEventTouchUpInside];
    
    [_keyboard.enterKey addTarget:self action:@selector(returnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    [_keyboard.nextKeyboardKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    
    return;
    
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
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
}

- (void)backword{
    [self.textDocumentProxy deleteBackward];
}

- (void)shift{
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
