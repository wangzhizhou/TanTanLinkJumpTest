//
//  ViewController.m
//  LinkDemo
//
//  Created by JokerAtBaoFeng on 2018/3/22.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "ViewController.h"
#import "MyTextView.h"
#import "TTFeedbackViewController.h"

@interface ViewController ()
<
UITextViewDelegate
>
@property (weak, nonatomic) IBOutlet UISwitch *systemHandleSwitch;
@property (nonatomic, strong) MyTextView *textView;
@end

@implementation ViewController

-(MyTextView *)textView {
    if(nil == _textView) {
        _textView  = [[MyTextView alloc] init];
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureUI];
}

- (void)configureUI {
    self.title = @"跳转测试";
    self.textView.text = @"欢迎使用探探, 在使用过程中有疑问请<a href=\"tantanapp://feedback\">反馈</a>";
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
}

- (void)viewWillLayoutSubviews {
    [self.textView sizeToFit];
    self.textView.center = self.view.center;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if([URL.scheme isEqualToString:@"tantanapp"])
    {
        if([[URL host] isEqualToString:@"feedback"]){
            [self gotoFeedbackViewController];
        }
    }
    
    return NO;
}

-(void)gotoFeedbackViewController {
    TTFeedbackViewController *feedVC = [[TTFeedbackViewController alloc] init];
    feedVC.title = NSStringFromClass([TTFeedbackViewController class]);
    [self.navigationController pushViewController:feedVC animated:YES];
}
@end
