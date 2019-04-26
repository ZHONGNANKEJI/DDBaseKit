//
//  BaseWebViewController.m
//  EHome
//
//  Created by Lifee on 2018/10/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic ,strong) UIWebView * webView ;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)base_initView {
    [super base_initView];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(self.view);
    }];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
     self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    if ([keyPath isEqualToString:@"contentSize"]) {
        //通过webview的contentSize获取内容高度
        CGFloat webViewHeight = [self.webView.scrollView contentSize].height;
        if (self.contentHeightBlock) {
            self.contentHeightBlock(webViewHeight);
        }
    }
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.delegate = self ;
        _webView.scrollView.scrollEnabled = NO;
        NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]] ;
        [_webView loadRequest:req];
    }
    return _webView ;
}
-(void)dealloc
{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}
@end
