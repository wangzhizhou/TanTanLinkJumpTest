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
@property (nonatomic, strong) UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _textView  = [[MyTextView alloc] init];
    self.textView.text = @"欢迎使用探探, 在使用过程中有疑问请<a href=\"tantanapp://feedback\">反馈</a>";
    [self.textView sizeToFit];
    self.textView.center = self.view.center;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if([URL.scheme isEqualToString:@"tantanapp"])
    {
        if(self.systemHandleSwitch.isOn)
        {
            return YES;
        }
        else
        {
            TTFeedbackViewController *feedVC = [[TTFeedbackViewController alloc] init];
            feedVC.title = NSStringFromClass([TTFeedbackViewController class]);
            [self.navigationController pushViewController:feedVC animated:YES];
        }
    }
    
    return NO;
}
@end
