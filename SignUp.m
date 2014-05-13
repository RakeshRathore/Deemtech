//
//  SignUp.m
//  Discount
//
//  Created by Sajith KG on 30/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SignUp.h"
#import "ViewController.h"
#import "AppDelegate.h"



@interface SignUp () {

    UIImageView *animationImageView;
    ViewController *viewController;
  
}

@end

@implementation SignUp

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // delegateMain = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    isRequestRunning = NO;

    
    self.view.backgroundColor = RGB(27, 34, 48);
    
    [self.signUpBtn.titleLabel setFont:LATO_BOLD(18)];
    self.signUpBtn.backgroundColor = TOPBAR_BG_COLOR;
    
    [self.signUpBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.facebookBtn setBackgroundColor:[UIColor clearColor]];
    [self.twitterBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.facebookBtn.titleLabel setFont:LATO_REGULAR(13)];
    [self.twitterBtn.titleLabel setFont:LATO_REGULAR(13)];
    [self.loginBtn.titleLabel setFont:LATO_REGULAR(13)];
    
    [self.loginBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
     viewController = MY_APP_DELEGATE.viewController;
    
    [self ChangeFrames];
}

- (void) ChangeFrames {
    
    self.logoImageView.frame = CGRectMake(self.logoImageView.frame.origin.x, 49, self.logoImageView.frame.size.width, self.logoImageView.frame.size.height);
    
    self.firstName.frame = CGRectMake(self.firstName.frame.origin.x, 157, self.firstName.frame.size.width, self.firstName.frame.size.height);
    self.lastName.frame = CGRectMake(self.lastName.frame.origin.x, self.firstName.frame.origin.y+self.firstName.frame.size.height+1, self.lastName.frame.size.width, self.lastName.frame.size.height);
    self.emailAddress.frame = CGRectMake(self.emailAddress.frame.origin.x, self.lastName.frame.origin.y+self.lastName.frame.size.height+1, self.emailAddress.frame.size.width, self.emailAddress.frame.size.height);
    self.passWord.frame = CGRectMake(self.passWord.frame.origin.x, self.emailAddress.frame.origin.y+self.emailAddress.frame.size.height+1, self.passWord.frame.size.width, self.passWord.frame.size.height);
    self.confirmPassword.frame = CGRectMake(self.confirmPassword.frame.origin.x, self.passWord.frame.origin.y+self.passWord.frame.size.height+1, self.confirmPassword.frame.size.width, self.confirmPassword.frame.size.height);
    
    self.signUpBtn.frame = CGRectMake(self.signUpBtn.frame.origin.x, self.confirmPassword.frame.origin.y+self.confirmPassword.frame.size.height+23, self.signUpBtn.frame.size.width, self.signUpBtn.frame.size.height);
    
    self.facebookBtn.frame = CGRectMake(self.facebookBtn.frame.origin.x, self.signUpBtn.frame.origin.y+self.signUpBtn.frame.size.height+23, self.facebookBtn.frame.size.width, self.facebookBtn.frame.size.height);
    
    self.twitterBtn.frame = CGRectMake(self.twitterBtn.frame.origin.x, self.facebookBtn.frame.origin.y+self.facebookBtn.frame.size.height+11, self.twitterBtn.frame.size.width, self.twitterBtn.frame.size.height);
    
    self.loginBtn.frame = CGRectMake(self.loginBtn.frame.origin.x, self.twitterBtn.frame.origin.y+self.twitterBtn.frame.size.height+23, self.loginBtn.frame.size.width, self.loginBtn.frame.size.height);
    
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y , self.contentView.frame.size.width, self.loginBtn.frame.origin.y+self.loginBtn.frame.size.height+25);
    
    [self.scrollView setContentSize:self.contentView.frame.size];
}

- (IBAction)signUpTapped:(id)sender
{
    [self.view endEditing:YES];
    
    NSArray *imageNames = @[@"loading1.png", @"loading2.png", @"loading3.png", @"loading4.png",
                            @"loading5.png", @"loading6.png", @"loading7.png", @"loading8.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 12, 19, 19)];
    animationImageView.alpha = 0.0;
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.5;
    [self.signUpBtn addSubview:animationImageView];
    [animationImageView startAnimating];

    [self.signUpBtn setTitle:@"Signing Up" forState:0];
    animationImageView.alpha = 1.0;
    
   
    
    
    [self callApi];
    
    
//    [self performSelector:@selector(signupSuccess) withObject:nil afterDelay:3];
}



-(void)callApi
{
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_emailAddress resignFirstResponder];
    [_passWord resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    
    if([_firstName.text length] == 0)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter username."];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];
    }
    else if([_lastName.text length] == 0)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter username."];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];


    }
    else if ([_emailAddress.text length]==0  || ![self validateEmailAddress:_emailAddress.text])
    {
        if ([_emailAddress.text length]==0)
            [AppDelegate showWithTitle:appName message:@"Please enter an email."];
        else if(![self validateEmailAddress:_emailAddress.text])
            [AppDelegate showWithTitle:appName message:@"Please enter an valid email."];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];


    }
    else if ([_passWord.text length] == 0)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter password."];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];


    }
    else if([_passWord.text length]< 8)
    {
        [AppDelegate showWithTitle:appName message:@"Please enter password having 8 characters"];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];


    }
    else if (![_passWord.text isEqualToString:_confirmPassword.text])
    {
        [AppDelegate showWithTitle:appName message:@"Password not Matching."];
        [animationImageView removeFromSuperview];
        [self.signUpBtn setTitle:@"Sign Up" forState:0];
    }
    else
    {
        NSString *str1 = [NSString stringWithFormat:@"user[first_name]=%@&user[last_name]=%@&user[email]=%@&user[password]=%@&user[user_type]=%@",_firstName.text,_lastName.text,_emailAddress.text,_passWord.text,@"Customer"];
        
        NSString *str               =   [[NSString alloc]initWithFormat:@"%@/user.json",MAIN_URL];

        
        NSURL *url      =   [NSURL URLWithString:str];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        [req setHTTPMethod:@"POST"];
        
        NSString *requestBodyString = [NSString stringWithFormat:@"%@",str1];
        NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:requestBody];
        
        NSURLResponse* response;
        NSError* error;
        NSLog(@"requset data = %@",req);
        NSData* result = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        NSLog(@"requset data = %@",result);
        NSString * rsltStr;
        
        rsltStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        NSLog(@"RESULT ##### :: %@",rsltStr);
        
        if (error)
        {
            NSLog(@"LOGIN FAILED%@",error);
            [animationImageView removeFromSuperview];
            [self.signUpBtn setTitle:@"Sign Up Failed" forState:0];


        }
        else{
            
            NSDictionary *dict  =   [rsltStr JSONValue];
            
            if([[dict valueForKey:@"authentication_token"] length]>0 && [[dict valueForKey:@"email"] length]>0)
            {
                [animationImageView removeFromSuperview];

                NSLog(@"dict :::::::: %@",dict);

                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[dict valueForKey:@"authentication_token"] forKey:@"auth_token"];
                [defaults setObject:[dict valueForKey:@"email"] forKey:@"email"];
                [defaults setObject:[dict valueForKey:@"id"] forKey:@"user_id"];
                [defaults setObject:[dict valueForKey:@"user_type"] forKey:@"user_type"];
                [defaults synchronize];
                 [self performSelector:@selector(signupSuccess) withObject:nil afterDelay:3];
            }
            else
            {
                [animationImageView removeFromSuperview];

                [self.signUpBtn setTitle:@"Sign Up Failed" forState:0];
            }
            
        }
    
    }
}

- (void) signupSuccess {
    
    [self.signUpBtn setTitle:@"Sign Up Successful!" forState:0];
    self.signUpBtn.backgroundColor = RGB(26, 193, 20);
    [animationImageView removeFromSuperview];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if([viewController respondsToSelector:@selector(ShowHomePage)])
        {
            [viewController ShowHomePage];
        }
    });
}

// Email Validation //
- (BOOL)validateEmailAddress:(NSString*)yourEmail
{
    //create a regex string which includes all email validation
    NSString *emailRegex    = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    //create predicate with format matching your regex string
    NSPredicate *email  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    //return True if your email address matches the predicate just formed
    return [email evaluateWithObject:yourEmail];
}


-(IBAction)loginTapped
{
    if([viewController respondsToSelector:@selector(loginCall)])
    {
        [viewController loginCall];
    }
}

#pragma mark  UITextfield

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView scrollRectToVisible:CGRectMake(0, 300, 320, 300) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark TWITTER

- (IBAction) twitterBtnCall {
    
    [MY_APP_DELEGATE checkTwitterLogin:self];
}

- (void) successTwitterLogin {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:appName
                              message:[NSString stringWithFormat:@"Username:%@ \n UserID:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_id"]]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    
     NSLog(@"successTwitterLogin");
    [self performSegueWithIdentifier:@"pushEmailView" sender:self];
}

- (void) failureTwitterLogin {
    
      NSLog(@"failureTwitterLogin");
}

#pragma mark - FACEBOOK

- (IBAction)facebookCall:(id)sender {
    
    [MY_APP_DELEGATE checkFacebookLoginCall:self];
}

#pragma mark  Login With Facebook

- (void) successFacebookLogin {
    
    //      NSLog(@"successFacebookLogin");
    
    // updating data to server functionality here
    [Loading showWithStatus:@"Fetching data..."];
    [self apiFQLIMe];
    
}

- (void) failureFacebookLogin {
    
    //      NSLog(@"failureFacebookLogin");
}

- (void)apiFQLIMe {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid,username,email FROM user WHERE uid=me()", @"query",
                                   nil];
    [[MY_APP_DELEGATE facebook] requestWithMethodName:@"fql.query"
                                            andParams:params
                                        andHttpMethod:@"POST"
                                          andDelegate:self];
}

#pragma mark  FBRequestDelegate Methods

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
    [Loading dismiss];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    [Loading dismiss];
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    // NSLog(@"request=%@",request.url);
     NSLog(@"result----%@",result);
    
    NSString *email=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"email"]]];
    NSString *uid=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"uid"]]];
    NSString *username=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[result objectForKey:@"username"]]];
    
    [self setFacebookEmailID:email];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:email forKey:@"email_id"];
    [dict setObject:username forKey:@"user_name"];
    [dict setObject:uid forKey:@"profile_id"];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:appName
                              message:[NSString stringWithFormat:@"Username:%@ \n Email:%@",username,email]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    
//    [Loading showWithStatus:@"Signing up..."];
//    
//    DLog(@"dict=%@",dict);
//    
//    wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[WebServices postURLRequest:@"fbLogin" andFields:dict]
//                                                                sel:@selector(finishedFacebookLogin:)
//                                                         andHandler:self
//                                                       andShowAlert:NO];
//    wspcontinuous=nil;
}

//#pragma mark  Facebook login
//
//-(void)finishedFacebookLogin:(NSMutableDictionary *)dictionary {
//    
//    //    NSLog(@"finishedFacebookLogin=%@",dictionary);
//    [Loading dismiss];
//    if ([[dictionary objectForKey:@"status"] isEqualToString:@"success"]) {
//        
//        [MY_APP_DELEGATE saveUserData:[dictionary objectForKey:@"data"]];
//        [MY_APP_DELEGATE setTabbarAfterLogin];
//        [MY_APP_DELEGATE showHome];
//        
//        if ([[[dictionary objectForKey:@"data"] objectForKey:@"registration"] isEqualToString:@"Yes"]) {
//            [MY_APP_DELEGATE showHowToUse];
//        }
//        
//    }else {
//        
//        if ([[dictionary objectForKey:@"error"] isEqualToString:@"Email ID exists"]) {
//            
//            [[[UIAlertView alloc] initWithTitle:@"Account exist already"
//                                        message:[NSString stringWithFormat:@"Already account exists for your Facebook email id (%@). Please do Sign in with this email id or use different Facebook account", self.facebookEmailID]
//                                       delegate:nil
//                              cancelButtonTitle:OK
//                              otherButtonTitles:nil] show];
//            [MY_APP_DELEGATE clearFBCache];
//            return;
//        }
//        
//        
//        [[[UIAlertView alloc] initWithTitle:ErrorTitle
//                                    message:[dictionary objectForKey:@"error"]
//                                   delegate:nil
//                          cancelButtonTitle:OK
//                          otherButtonTitles:nil] show];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calling_SignUpServices
{



}

@end
