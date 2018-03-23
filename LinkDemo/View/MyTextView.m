//
//  MyTextView.m
//  LinkDemo
//
//  Created by JokerAtBaoFeng on 2018/3/22.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

-(instancetype)init {
    if(self = [super init])
    {
        self.editable = NO;
        NSDictionary *linkAttributes = @{
                                         NSForegroundColorAttributeName:
                                             [UIColor blueColor],
                                         
                                         NSUnderlineColorAttributeName:
                                             [UIColor blueColor],
                                         
                                         NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
                                         };
        self.linkTextAttributes = linkAttributes;
        self.dataDetectorTypes = UIDataDetectorTypeLink;
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)setText:(NSString *)text {
    NSString *pattern = @"<a.*href\\s*=\\s*\"(.*)\".*>(.*)</a>";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regExp matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    for(NSTextCheckingResult *match in matches) {
        NSString *href = [text substringWithRange:[match rangeAtIndex:1]];
        NSString *anchorText = [text substringWithRange:[match rangeAtIndex:2]];
        NSRange anchorTagRange = match.range;
        [attributedText replaceCharactersInRange:anchorTagRange withString:anchorText];
        NSRange anchorTextRange = NSMakeRange(anchorTagRange.location, anchorText.length);
        [attributedText addAttribute:NSLinkAttributeName value:href range:anchorTextRange];
    }

    self.attributedText = attributedText;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    self.selectedTextRange = nil;
    [self resignFirstResponder];
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self disableLongPressGestures];
}

- (void)disableLongPressGestures {
    for(UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        {
            gestureRecognizer.enabled = NO;
        }
    }
}
@end
