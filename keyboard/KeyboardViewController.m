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
@property (strong, nonatomic) SJKeyboard *numKeyboard;
@property (strong, nonatomic) SJKeyboard *specialKeyboard;
@property (strong, nonatomic) NSTimer *timer;
//@property (nonatomic) BOOL isShift;
@property (nonatomic) BOOL isNumKeyboard;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isNumKeyboard = NO;
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"SJKeyboard" owner:nil options:nil] firstObject];
    self.numKeyboard = [[NSBundle mainBundle] loadNibNamed:@"SJKeyboard" owner:nil options:nil][1];
    self.specialKeyboard = [[NSBundle mainBundle] loadNibNamed:@"SJKeyboard" owner:nil options:nil][2];
    
    self.inputView = _keyboard;
    [self setPrimaryLanguage:@"ko"];
    
    [self keyboardSetting:_keyboard];
    [self keyboardSetting:_numKeyboard];
    [self keyboardSetting:_specialKeyboard];
    
    
   
}


- (void)keyboardSetting:(SJKeyboard*)keyboard{
    
    for (UIButton *key in keyboard.keys) {
        [key addTarget:self action:@selector(key:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [keyboard.backspaceKey addTarget:self action:@selector(backword) forControlEvents:UIControlEventTouchUpInside];
    
    
    [keyboard.shiftKey addTarget:self action:@selector(shift) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboard.spaceKey addTarget:self action:@selector(space) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboard.enterKey addTarget:self action:@selector(returnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    [keyboard.nextKeyboardKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    
    [keyboard.numberKeyboardKey addTarget:self action:@selector(numberKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(backwordLong:)];
    [keyboard.backspaceKey addGestureRecognizer:longPressGR];
    
    [keyboard.leftSpace setPriority:UILayoutPriorityDefaultHigh];
    [keyboard.rightSpace setPriority:UILayoutPriorityDefaultLow];
    [keyboard layoutIfNeeded];
    
    
    UISwipeGestureRecognizer *rightSGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    [rightSGR setDirection:UISwipeGestureRecognizerDirectionRight];
    
    UISwipeGestureRecognizer *leftSGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    
    [leftSGR setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    
    [keyboard addGestureRecognizer:rightSGR];
    [keyboard addGestureRecognizer:leftSGR];
}


- (void)rightSwipe:(UISwipeGestureRecognizer*)sender{
//    SJKeyboard *keyboard = (SJKeyboard*)sender.view;
    
    [_keyboard.leftSpace setPriority:UILayoutPriorityDefaultLow];
    [_keyboard.rightSpace setPriority:UILayoutPriorityDefaultHigh];
    [_numKeyboard.leftSpace setPriority:UILayoutPriorityDefaultLow];
    [_numKeyboard.rightSpace setPriority:UILayoutPriorityDefaultHigh];
    [_specialKeyboard.leftSpace setPriority:UILayoutPriorityDefaultLow];
    [_specialKeyboard.rightSpace setPriority:UILayoutPriorityDefaultHigh];
//    [keyboard layoutIfNeeded];
}

- (void)leftSwipe:(UISwipeGestureRecognizer*)sender{
//    SJKeyboard *keyboard = (SJKeyboard*)sender.view;
    
    [_keyboard.leftSpace setPriority:UILayoutPriorityDefaultHigh];
    [_keyboard.rightSpace setPriority:UILayoutPriorityDefaultLow];
    [_numKeyboard.leftSpace setPriority:UILayoutPriorityDefaultHigh];
    [_numKeyboard.rightSpace setPriority:UILayoutPriorityDefaultLow];
    [_specialKeyboard.leftSpace setPriority:UILayoutPriorityDefaultHigh];
    [_specialKeyboard.rightSpace setPriority:UILayoutPriorityDefaultLow];
//    [keyboard layoutIfNeeded];
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
    [self.textDocumentProxy insertText:key.titleLabel.text];
    
//    if (_isShift) {
//        [self shift];
//    }
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
    if (_isNumKeyboard) {
        
        
        if (_numKeyboard.isShift) {
            self.inputView = _numKeyboard;
        }
        
        else
            self.inputView = _specialKeyboard;
        
        
        _numKeyboard.isShift = !_numKeyboard.isShift;
        return;
    }
    
    
    if (!_keyboard.isShift) {
        [UIView setAnimationsEnabled:NO];
        for (UIButton* key in _keyboard.keys) {
            [key setTitle:[key.titleLabel.text uppercaseString] forState:UIControlStateNormal];
        }
        [_keyboard.shiftKey setBackgroundColor:[UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f]];
        
        [UIView setAnimationsEnabled:YES];
        _keyboard.isShift = YES;
    }
    
    else {
        
        [UIView setAnimationsEnabled:NO];
        for (UIButton* key in _keyboard.keys) {
            [key setTitle:[key.titleLabel.text lowercaseString] forState:UIControlStateNormal];
        }
        
        [_keyboard.shiftKey setBackgroundColor:[UIColor colorWithWhite:0.23f alpha:1.0f]];
        
        [UIView setAnimationsEnabled:YES];
        _keyboard.isShift = NO;
    }
    
}

- (void)numberKeyboard{
    if (_isNumKeyboard) {
        self.inputView = _keyboard;
        _isNumKeyboard = NO;
        return;
    }
    
    self.inputView = _numKeyboard;
    _isNumKeyboard = YES;
}

- (void)space{
    [self.textDocumentProxy insertText:@" "];
}

- (void)returnSelector{
    [self.textDocumentProxy insertText:@"\n"];
}





@end
