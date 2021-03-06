/*
     File: ModalViewController.m
 Abstract: The view controller presented modally.
  Version: 1.8
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 */

#import "ModalViewController.h"
#import "Constants.h"


@interface ModalViewController ()
- (id)infoValueForKey:(NSString *)key;
@end

@implementation ModalViewController


@synthesize appName, copyright, dismissButton, webView;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    self.title = NSLocalizedString(@"ModalTitle", @"");
	
	return self;
}
*/

- (id)initWithAppDelegate:(id)appDelegate {
	
	self = [ super init ];
	if (self != nil) {
		NSLog(@"inside initwithappdelegate");
		//UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 250, 100, 100) ];
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
		NSString *title = @"<- Back";
		button.backgroundColor = [UIColor clearColor];
		[button setTitle: title forState:UIControlStateNormal];
		dismissButton = button;
		CGRect buttonFrame = CGRectMake(0, 420, 75, 25);
		//CGRect buttonFrame = RoundedRectView(180, 250, 100, 100);
		
		dismissButton.frame = buttonFrame;	
		
		webView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
		webView.delegate = self;
		[webView setBackgroundColor:[UIColor blackColor]];
		//[webView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed: @"numbers.png"]]];
		//webView.alpha = 0.;
		
		[webView setOpaque:NO];
		webView.userInteractionEnabled = YES;
		webView.dataDetectorTypes = UIDataDetectorTypeNone;
		webView.autoresizingMask = 1 << 1;
		
		
		
		
		[self.view addSubview:webView];
		[self.view addSubview:dismissButton];
		
		
		 
	}
		 
	return self;
}

 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return YES;
 }
 

- (void)dealloc
{
    [appName release];
    [copyright release];
	[webView release];
	[super dealloc];
}

- (void)viewDidLoad
{
	
	//self.view.backgroundColor = [UIColor blackColor];
	
	
	self.appName.text = [self infoValueForKey:@"CFBundleName"];
	self.copyright.text = [self infoValueForKey:@"NSHumanReadableCopyright"];
}

- (void)viewDidUnload
{
	self.appName = nil;
	self.copyright = nil;
}

- (id)infoValueForKey:(NSString *)key
{
    // fetch objects from our bundle based on keys in our Info.plist
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key] ? : [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
}

- (IBAction)dismissAction:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}
/*
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *loadURL = [ [ request URL ] retain ]; // retain the loadURL for use
    if ( ( [ [ loadURL scheme ] isEqualToString: @"http" ] || [ [ loadURL scheme ] isEqualToString: @"https" ] ) && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) // Check if the scheme is http/https. You can also use these for custom links to open parts of your application.
        return ![ [ UIApplication sharedApplication ] openURL: [ loadURL autorelease ] ]; // Auto release the loadurl because we wont get to release later. then return the opposite of openURL, so if safari cant open the url, open it in the UIWebView.
    [ loadURL release ];
    return YES; // URL is not http/https and should open in UIWebView
}
*/
@end
