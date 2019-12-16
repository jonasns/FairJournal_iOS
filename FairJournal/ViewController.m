//
//  ViewController.m
//  FairJournal
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewsss;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webViewsss.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://thefairjournal.com/"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webViewsss loadRequest:requestObj];
    [self addPullToRefreshToWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma  mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.activityIndicator startAnimating];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    
    
    NSString *jsp = @"var menus = document.getElementsByClassName('');"
    "for (var i = 0; i < menus.length; i++) {"
    "menus[i].style.display = 'none';"
    "}";
    [self->_webViewsss stringByEvaluatingJavaScriptFromString:jsp];




    NSString *js = @"var menus = document.getElementsByClassName('logo-holder');"
    "for (var i = 0; i < menus.length; i++) {"
    "menus[i].style.display = 'none';"
    "}";
    [self->_webViewsss stringByEvaluatingJavaScriptFromString:js];

//
//    NSString *jss = @"var menus = document.getElementsByClassName('mk-button-container _ relative    block text-center ');"
//    "for (var i = 0; i < menus.length; i++) {"
//    "menus[i].style.display = 'none';"
//    "}";
//    [self->_webViewsss stringByEvaluatingJavaScriptFromString:jss];

//    NSString *jsss = @"var menus = document.getElementsByClassName('btmFooter');"
//    "for (var i = 0; i < menus.length; i++) {"
//    "menus[i].style.display = 'none';"
//    "}";
//    [self->_webViewsss stringByEvaluatingJavaScriptFromString:jsss];
//
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}
- (IBAction)back:(id)sender {
    [_webViewsss goBack];
}
- (IBAction)home:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://thefairjournal.com/"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webViewsss loadRequest:requestObj];
}
- (IBAction)forward:(id)sender {
    [_webViewsss goForward];
}

- (void)addPullToRefreshToWebView{
    UIColor *whiteColor = [UIColor whiteColor];
    UIRefreshControl *refreshController = [UIRefreshControl new];
    NSString *string = @"Pull down to refresh...";
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : whiteColor };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    refreshController.bounds = CGRectMake(0, 0, refreshController.bounds.size.width, refreshController.bounds.size.height);
    refreshController.attributedTitle = attributedString;
    [refreshController addTarget:self action:@selector(refreshWebView:) forControlEvents:UIControlEventValueChanged];
    [refreshController setTintColor:whiteColor];
    [self.webViewsss.scrollView addSubview:refreshController];
}

- (void)refreshWebView:(UIRefreshControl*)refreshController{
    [self.webViewsss reload];
    [refreshController endRefreshing];
}

@end
