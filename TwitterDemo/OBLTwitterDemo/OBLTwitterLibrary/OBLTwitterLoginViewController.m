//
//  OBLLoginViewController.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLTwitterLoginViewController.h"


static NSString * const newPinJS = @"var d = document.getElementById('oauth-pin'); if (d == null) d = document.getElementById('oauth_pin'); if (d) { var d2 = d.getElementsByTagName('code'); if (d2.length > 0) d2[0].innerHTML; }";
static NSString * const oldPinJS = @"var d = document.getElementById('oauth-pin'); if (d == null) d = document.getElementById('oauth_pin'); if (d) d = d.innerHTML; d;";


@interface OBLTwitterLoginViewController ()

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIWebView *theWebView;
@property (nonatomic, strong) UILabel *loadingText;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) OBLToken *requestToken;

@end

@implementation OBLTwitterLoginViewController

@synthesize navBar, theWebView, loadingText, spinner, requestToken, backgroundColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
        
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pasteboardChanged:) name:UIPasteboardChangedNotification object:nil];
    
    // Set view properties
    self.view = [[UIView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.view.backgroundColor = (self.backgroundColor) ? self.backgroundColor : [UIColor lightGrayColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Display navigatoinBar.
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, (UIDevice.currentDevice.systemVersion.floatValue >= 7.0f)?64:44)];
    self.navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"Twitter Login"];
	navItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
	[self.navBar pushNavigationItem:navItem animated:NO];
    
    // Display webview.
    theWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, navBar.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navBar.bounds.size.height)];
    self.theWebView.hidden = YES;
    self.theWebView.delegate = self;
    self.theWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.theWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.theWebView.scrollView.clipsToBounds = NO;
    self.theWebView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.theWebView];
    [self.view addSubview:self.navBar];
    
    // Display loading message
    loadingText = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/2)-40, (self.view.bounds.size.height/2)-10-7.5, 100, 15)];
	self.loadingText.text = @"Please Wait...";
	self.loadingText.backgroundColor = [UIColor clearColor];
	self.loadingText.textColor = [UIColor blackColor];
	self.loadingText.textAlignment = NSTextAlignmentLeft;
	self.loadingText.font = [UIFont boldSystemFontOfSize:15];
	[self.view addSubview:self.loadingText];
	
    // Display activity indicator
	spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.spinner.center = CGPointMake((self.view.bounds.size.width/2)-60, (self.view.bounds.size.height/2)-10);
	[self.view addSubview:self.spinner];
	[self.spinner startAnimating];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Get oauth_token
        NSString *reqString = [OBLTwitterLogin getRequestTokenString];
        
        if (reqString.length == 0) {
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(),^(void) {
                @autoreleasepool {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            });
        } else {
            self.requestToken = [OBLToken tokenWithHTTPResponseBody:reqString];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",self.requestToken.key]]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    [self.theWebView loadRequest:request];
                }
            });
        }
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)gotPin:(NSString *)pin {
    self.requestToken.verifier = pin;
    
    // Finish authentication usgin oauth_token
    NSError * error = [OBLTwitterLogin finishAuthWithRequestToken:self.requestToken];
    
    if (error)
    {
        [OBLLog logMessage:[NSString stringWithFormat:@"Twitter login failed with error : %@", error]];
    }
    else
    {
        [OBLLog logMessage:@"Twitter login successful."];
    }
    
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginCompleted:)])
    {
        // Call delegate method
        [self.loginDelegate loginCompleted:error];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pasteboardChanged:(NSNotification *)note {
	
    if (![note.userInfo objectForKey:UIPasteboardChangedTypesAddedKey]) {
        return;
    }
    
    NSString *string = [[UIPasteboard generalPasteboard]string];
	
	if (string.length != 7 || !string.fhs_isNumeric) {
        return;
    }
	
	[self gotPin:string];
}

- (NSString *)locatePin {
	NSString *pin = [[self.theWebView stringByEvaluatingJavaScriptFromString:newPinJS]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (pin.length == 7) {
		return pin;
	} else {
		pin = [[self.theWebView stringByEvaluatingJavaScriptFromString:oldPinJS]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		if (pin.length == 7) {
			return pin;
		}
	}
	return nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.theWebView.userInteractionEnabled = YES;
    NSString *authPin = [self locatePin];
    
    if (authPin.length > 0) {
        [self gotPin:authPin];
        return;
    }
    
    NSString *formCount = [webView stringByEvaluatingJavaScriptFromString:@"document.forms.length"];
    
    if ([formCount isEqualToString:@"0"]) {
        self.navBar.topItem.title = @"Select and Copy the PIN";
    }
	
	[UIView beginAnimations:nil context:nil];
    self.spinner.hidden = YES;
    self.loadingText.hidden = YES;
	[UIView commitAnimations];
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.theWebView.hidden = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.theWebView.userInteractionEnabled = NO;
    [self.theWebView setHidden:YES];
    self.spinner.hidden = NO;
    self.loadingText.hidden = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (strstr([request.URL.absoluteString UTF8String], "denied=")) {
		[self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    NSData *data = request.HTTPBody;
	char *raw = data?(char *)[data bytes]:"";
	
	if (raw && (strstr(raw, "cancel=") || strstr(raw, "deny="))) {

        if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginCompleted:)])
        {
            [OBLLog logMessage:@"User canceled Twitter login."];
            // Call delegate method
            [self.loginDelegate loginCompleted:[NSError errorWithDomain:@"OBLTwitter" code:-1 userInfo:@{NSLocalizedDescriptionKey:LOGIN_CANCELED}]];
        }
        
		[self dismissViewControllerAnimated:YES completion:nil];
		return NO;
	}
    
	return YES;
}

// User pressed cancel bar button item
- (void)close
{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginCompleted:)])
    {
        [OBLLog logMessage:@"User canceled Twitter login."];
        // Call delegate method
        [self.loginDelegate loginCompleted:[NSError errorWithDomain:@"OBLTwitter" code:-1 userInfo:@{NSLocalizedDescriptionKey:LOGIN_CANCELED}]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.loginDelegate = nil;
    self.backgroundColor = nil;
    self.navBar = nil;
    self.theWebView = nil;
    self.loadingText = nil;
    self.spinner = nil;
}

@end
