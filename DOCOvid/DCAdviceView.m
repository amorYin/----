//
//  DCAdviceView.m
//  DOCOvid
//
//  Created by amor on 13-12-23.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCAdviceView.h"
#import "DCPopView.h"
//#import "DCMessageView.h"
@interface DCAdviceView()<UITextFieldDelegate,UITextViewDelegate>
{
    DCPopView *_popView;
    UITextView *_content;
    UITextField *_phone;
    UITextField *_email;
}
@end
@implementation DCAdviceView
#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)strin
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.258 animations:^{
        if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft) {
            if ([textField isEqual:_phone]) {
                CGPoint p =  _popView.center;
                _popView.center=CGPointMake(284, p.y);
            }
            if ([textField isEqual:_email]) {
                CGPoint p =  _popView.center;
                _popView.center=CGPointMake(184, p.y);
            }
        }else{
            if ([textField isEqual:_phone]) {
                CGPoint p =  _popView.center;
                _popView.center=CGPointMake(484, p.y);
            }
            if ([textField isEqual:_email]) {
                CGPoint p =  _popView.center;
                _popView.center=CGPointMake(584, p.y);
            }
        }
    }];

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.258 animations:^{
    CGPoint p =  _popView.center;
    _popView.center=CGPointMake(384, p.y);
    }];
}
#pragma mark -UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView.text isEqualToString:@"请输入您的意见和建议......（300字以内）"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1){
        textView.text = @"请输入您的意见和建议......（300字以内）";
        textView.textColor = [UIColor lightGrayColor];
    }
        
}
#pragma mark - acyon
- (void)sendAdvice:(id)sender
{
    
    [_popView dismissAnimated:YES];
//    DCMessageView *uu = [[DCMessageView alloc] initWithTitle:Nil message:@"添加成功"];
//    [uu show];
}
- (void) show
{
    if (!_popView) {
        _popView = [[DCPopView alloc] initWithTitle:@"意见反馈" size:CGSizeMake(406, 445)];
        [_popView handleContentView:^(UIView *popView) {
            @autoreleasepool {
                
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(25, 20, 336, 180)];
                img.image = [[UIImage imageNamed:@"text_input_bg"] stretchableImageWithLeftCapWidth:168 topCapHeight:15];
                [popView addSubview:img];
                
                if (!_content) {
                    _content = [[UITextView alloc] initWithFrame:CGRectMake(26, 20, 334, 180)];
                    _content.text = @"请输入您的意见和建议......（300字以内）";
                    _content.keyboardType = UIKeyboardTypeDefault;
                    _content.delegate = self;
                    _content.textColor = [UIColor lightGrayColor];
                    _content.backgroundColor = [UIColor clearColor];
                    [popView addSubview:_content];
                }
                
                UILabel *lal = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_content.frame)+17, 336, 20)];
                lal.text = @"您的手机号码：（选填）";
                lal.backgroundColor = [UIColor clearColor];
                lal.textColor = [UIColor lightGrayColor];
                lal.font = Cond_font(20);
                
                [popView addSubview:lal];
                
                UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_content.frame)+45, 336, 30)];
                img1.image = [[UIImage imageNamed:@"text_input_bg"] stretchableImageWithLeftCapWidth:168 topCapHeight:15];
                [popView addSubview:img1];
                
                if (!_phone) {
                    _phone = [[UITextField alloc] initWithFrame:CGRectMake(28, CGRectGetMaxY(_content.frame)+45, 330, 30)];
                    _phone.keyboardType = UIKeyboardTypeNumberPad;
                    _phone.delegate = self;
                    _phone.textColor = [UIColor whiteColor];
                    _phone.backgroundColor = [UIColor clearColor];
                    [popView addSubview:_phone];
                }
                
                UILabel *lal1 = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_phone.frame)+17, 336, 20)];
                lal1.text = @"您的电子邮件：（选填）";
                lal1.backgroundColor = [UIColor clearColor];
                lal1.font = Cond_font(20);
                lal1.textColor = [UIColor lightGrayColor];
                [popView addSubview:lal1];
                
                UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_phone.frame)+45, 336, 30)];
                img2.image = [[UIImage imageNamed:@"text_input_bg"] stretchableImageWithLeftCapWidth:168 topCapHeight:15];
                [popView addSubview:img2];
                
                if (!_email) {
                    _email = [[UITextField alloc] initWithFrame:CGRectMake(28, CGRectGetMaxY(_phone.frame)+45, 330, 30)];
                    _email.keyboardType = UIKeyboardTypeEmailAddress;
                    _email.delegate = self;
                    _email.textColor = [UIColor whiteColor];
                    _email.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"text_input_bg"] stretchableImageWithLeftCapWidth:168 topCapHeight:15]];
                    [popView addSubview:_email];
                }
                
                UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(280, CGRectGetMaxY(_email.frame)+20, 86, 34)];
                [btn1 setTitle:@"提交" forState:UIControlStateNormal];
                [btn1 setBackgroundImage:[UIImage imageNamed:@"advice_btn_n"] forState:UIControlStateNormal];
                [btn1 setBackgroundImage:[UIImage imageNamed:@"advice_btn_h"] forState:UIControlStateHighlighted];
                [btn1 addTarget:self action:@selector(sendAdvice:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn1];
            }
        }];
    }
    [_popView show];
}

@end
