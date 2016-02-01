//
//  XWPhoneViewController.m
//  RegularExpressions
//
//  Created by Edwin on 16/2/1.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "XWViewController.h"
#import "NSString+RegularExpressions.h"
#import "XWRegularExpression.h"
// 随机色
// RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface XWViewController ()<UITextFieldDelegate>
/**
 *  判断类型
 */
@property (strong, nonatomic)  UILabel *titleLabel;
/**
 *  判断结果
 */
@property (strong, nonatomic)  UILabel *resultLabel;
/**
 *  输入要判断的字符串
 */
@property (strong, nonatomic)  UITextField *textField;
@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XWRandomColor;
    [self gnerateUI];
    switch (self.type) {
        case RegularExpressionTypePhone:
            self.navigationItem.title = @"电话号码";
            self.titleLabel.text = @"电话号码";
            break;
        case RegularExpressionTypeEmail:
            self.navigationItem.title = @"邮箱地址";
            self.titleLabel.text = @"邮箱地址";
            break;
        case RegularExpressionTypeuserPsswordVc:
            self.navigationItem.title = @"用户密码";
            self.titleLabel.text = @"用户密码";
            break;
        case RegularExpressionTypeIDCardVc:
            self.navigationItem.title = @"身份证号码";
            self.titleLabel.text = @"身份证号码";
            break;
        case RegularExpressionTypeAllNumber:
            self.navigationItem.title = @"全数字";
            self.titleLabel.text = @"全数字";
            break;
        case RegularExpressionTypeUrl:
            self.navigationItem.title = @"网页地址URL";
            self.titleLabel.text = @"网页地址URL";
            break;
        case RegularExpressionTypeIPAddress:
            self.navigationItem.title = @"IP地址";
            self.titleLabel.text = @"IP地址";
            break;
        case RegularExpressionTypeChinese:
            self.navigationItem.title = @"汉字";
            self.titleLabel.text = @"汉字";
            break;
        default:
            self.navigationItem.title = @"英文字符";
            self.titleLabel.text = @"英文字符";
            break;
    }
 
}

-(void)gnerateUI{
    
    self.resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0 , 100, 40)];
    self.resultLabel.center = self.view.center;
    self.resultLabel.backgroundColor = [UIColor whiteColor];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    self.resultLabel.textAlignment = NSTextAlignmentLeft;
    self.resultLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:self.resultLabel];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 32)];
    CGPoint labelCenter;
    labelCenter.x = 100;
    labelCenter.y = self.view.center.y-50;
    self.titleLabel.center = labelCenter;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:self.titleLabel];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+10, CGRectGetMinY(self.titleLabel.frame),150, 32)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.placeholder = @"请输入字符串";
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.textField.returnKeyType = UIReturnKeyNext;
    self.textField.clearsOnBeginEditing = YES;
    self.textField.adjustsFontSizeToFitWidth = YES;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置对齐方式
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
}

-(void)judgeTextFieldResultType:(NSString *)inputText{
    XWRegularExpression *expression = [[XWRegularExpression alloc]init];
    switch (self.type) {
        case RegularExpressionTypePhone:
            if ([expression isPhoneNumber:inputText]) {
                self.resultLabel.text = @"输入的是电话号码";
            }else{
                self.resultLabel.text = @"输入的电话号码格式错误";
            }
            break;
        case RegularExpressionTypeEmail:
            if ([expression detectionIsEmailQualified:inputText]) {
                self.resultLabel.text = @"输入的是正确的邮箱地址";
            }else{
                self.resultLabel.text = @"输入的邮箱地址格式错误";
            }
            
            break;
        case RegularExpressionTypeuserPsswordVc:
            if ([expression detectionIsPasswordQualified:inputText]) {
                self.resultLabel.text = @"输入密码格式正确，是以字母开头，包含数字，特殊字符以字母结尾";
            }else{
                self.resultLabel.text = @"输入的密码格式错误";
            }
            
            break;
        case RegularExpressionTypeIDCardVc:
            if ([expression detectionIsIdCardNumberQualified:inputText]) {
                self.resultLabel.text = @"输入的身份证号码格式正确";
            }else{
                self.resultLabel.text = @"输入的身份证号码格式错误";
            }
            break;
        case RegularExpressionTypeAllNumber:
            if ([expression detectionIsAllNumber:inputText]) {
                self.resultLabel.text = @"输入的是全为数字";
            }else{
                self.resultLabel.text = @"输入的数字格式错误";
            }
            
            break;
        case RegularExpressionTypeUrl:
            if ([expression detectionIsUrl:inputText]) {
                self.resultLabel.text = @"输入的URL地址正确";
            }else{
                self.resultLabel.text = @"输入的url地址格式错误";
            }
            
            break;
        case RegularExpressionTypeIPAddress:
            if ([expression detectionIsIPAddress:inputText]) {
                self.resultLabel.text = @"输入的IP地址正确";
            }else{
                self.resultLabel.text = @"输入的IP地址格式错误";
            }
            break;
        case RegularExpressionTypeChinese:
            if ([expression detectionIsChinese:inputText]) {
                self.resultLabel.text = @"输入的是汉字";
            }else{
                self.resultLabel.text = @"输入的不是汉字";
            }
            break;
        default:
        case RegularExpressionTypeEnglishAlphabetVc:
            if ([expression detectionIsEnglishAlphabet:inputText]) {
                self.resultLabel.text = @"输入的是全为26个字母组成的字符串";
            }else{
                self.resultLabel.text = @"输入的字母字符串格式错误";
            }
            
            break;
    }
}
#pragma mark --UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //收起键盘
    [self.textField resignFirstResponder];
    NSString *inputText = textField.text;
    [self judgeTextFieldResultType:inputText];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
