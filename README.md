SocialPluginsiOS
================

Social media plugins for iOS

Introduction
------------

SocialPluginsiOS provides integration with Facebook, Google+ and Twitter in iOS in the simplest and easiest way.

It has separate libraries for Facebook, Google+ and Twitter, so you can use any/some of them or all at the same time.

## Features

Facebook Library:
* Login/Logout with Facebook in your application. (with different permissions)
* Fetch Facebook user's profile.
* Request for additional Facebook permissions.
* Post feed status on user's wall.
* Fetch Facebook user's friends and their profile details.
* Provides functinality to turn debugging ON or OFF (Log message makes easy to locate error).

Google+ Library:
* Sign in and Sign out with Google+ in your application
* Share posts with friends.Users can post in the Google+ which includes text, photos and URL attachments.Interactive posts allow users to share your site or app with their friends and invite them to take a specific action.
* Fetch signed in user's profile details.
* Fetch user's Google+ friend's profile information.
* Provides functionality of debugging.Debugging can be activated/deactivated as per user's requirement.


Twitter Library:
* Login/Logout with Twitter in your application. (with different permissions)
* Tweet on user's account from application.
* Provides functinality to turn debugging ON or OFF (Log message makes easy to locate error).


## Requirements 

* iOS 6.1 or above
* ARC memory management.

## Adding library to project

### Source files

Steps to include library to project:

1. Download the Library folder from (https://github.com/ObjectLounge/SocialPluginsiOS).
2. Open your project in Xcode, then drag and drop Library folders(as mentioned below) that you need in your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
  - Add Protocol and Utility folder
  - Add FacebookLibrary for Facebook integration
  - Add Google+ Library for Google+ integration
  - Add TwitterLibrary for Twitter integration

3. Include library files wherever you need it like `#import "OBLFacebookogin.h"` for Facebook.

## APIs documentation

####FacebookLibrary:

You can see the demo code present in SampleFacebookCode Folder, (https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode) .

Login/Logout:
* `OBLFacebookLogin`
  - Refer to **[OBLFacebookLogin.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookLogin.h)**
  - FacebookLoging class provide basic utilities for the Facebook like login, logout, loging with permissions.
  - Request new read or publish permission.
  - User has to call handleOpenUrl:url in the application:openURL:sourceApplication:annotation: of UIApplicationDelegate... for handling incoming url like `[OBLFacebookLogin handleOpenUrl:(NSURL *)url];`
  - Also call applicationActiveHandle in applicationDidBecomeActive:application for updating session info like `[OBLFacebookLogin applicationActiveHandle];`

* `OBLFacebookPermission`
  - Refer to **[OBLFacebookPermission.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookPermission.h)**
  - List all the Facebook Permissions that can be used with this library.

Social media query (Fetch data):

* `OBLFacebookQuery`
  - Refer to **[OBLFacebookQuery.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookQuery.h)**
  - Class fetches the user and user's friends' profile.

Social media posting:

* `OBLFacebookPost`
  - Refer to **[OBLFacebookPost.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookPost.h)**
  - This class allows user to post on user's wall.


Profile details:

* `OBLFacebookUser`
  - Refer to **[OBLFacebookUser.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookUser.h)**
  - Main class having all profile information of Facebook user

* `OBLFacebookFriend`
  - Refer to **[OBLFacebookFriend.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookFriend.h)**
  - Class having all profile information of Facebook friend

Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Call this class and set facebookDebug to YES to turn on the error logs like `[OBLLog setFacebookDebug:YES];`

####Google+ Library:

You can check the demo code present in SampleGoogle+Code Folder, (https://github.com/jeneena-obl/SocialPluginsiOS/tree/beta/SampleGoogle%2BCode) .

Sign in,Sign out and Disconnect:
* `OBLGooglePlusLogin`
  - Refer to **[OBLGooglePlusLogin.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusLogin.h)**
  - This class provides functionalities such as login, logout and disconnect for google+ users.
  - Before calling methods like `login`, set clientID which can be obtained from Google APIs Console by creating an APIs Console project, enabling the Google+ API and then by creating a client ID.Also set scopes and actions, shouldFetchGoogleUserEmail, shouldFetchGoogleUserID, shouldFetchGooglePlusUser (optional) as required.
  - There are delegates such as finishedWithLogin,didDisconnectWithError to be implemented which gives notification about successful completion of process or error if any.
  - Call the URL handler `handleURL:sourceApplication:annotation:` from app delegate's URL handler  `application:openURL:sourceApplication:annotation:`. This handler will properly handle the URL that your application receives at the end of the authentication process.
  - `logout` is used to sign out the user.This method removes the OAuth 2.0 token from the keychain.
  - `disconnect` is used to disconnect the user from the app and revoking previous authentication.If the operation  succeeds, the OAuth 2.0 token is also removed from keychain. The token is needed to disconnect so do not call `logout` if `disconnect` is to be called

Social media profile details query:

* `OBLGoogelPlusQuery`
  - Refer to **[OBLGoogelPlusQuey.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGoogelPlusQuey.h)**
  - This class fetches the user and user's friends profile information.
* `OBLGooglePlusUser`
  - Refer to **[OBLGooglePlusUser.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusUser.h)**
  - This class has profile information of signed in user.
* `OBLGooglePlusFriend`
  - Refer to **[OBLGooglePlusFriend.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusFriend.h)**
  - This class has information of signed in user's friends profile detail.

Social media posting:

* `OBLGooglePlusShare`
  - Refer to **[OBLGooglePlusShare.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusShare.h)**
  - This class allows user to share posts.
  - There are various methods available for posting like basic sharing with thumbnail image,title,description,attaching a     url,sharing with deep linking in interactive posts.
  - For interactive posts,some of the valid labels for callToAction buttons are defined in file `CallToActionButtonLabels` class.For getting a complete list of valid button labels,check https://developers.google.com/+/mobile/ios/share/interactive-post 

Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Call this class and set googlePlusDebug to YES to turn on the error logs .When debugging is set to YES, it will shows error and other log messages.Eg: `[OBLLog setGooglePlusDebug:YES];`

####Twitter Library:

You can see the demo code present in `TwitterDemo` Folder.

Login/Logout:

* `OBLTwitterLoginViewController`
  - Refer to **[OBLTwitterLoginViewController.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/OBLTwitterLibrary/OBLTwitterLoginViewController.h)**
  - It allows to log in to Twitter.

* `OBLTwitterLogin`
  - Refer to **[OBLTwitterLogin.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/OBLTwitterLibrary/OBLTwitterLogin.h)**
  - It allows to set Twitter consumer key and consumer secret.
  - It allows to check if user is already logged in.
  - It allows to logout from Twitter.


Tweet:

* `OBLTwitter`
  - Refer to **[OBLTwitter.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/OBLTwitterLibrary/OBLTwitter.h)**
  - This class allows to tweet on user's wall.


Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Use `setTwitterDebug:` method of `OBLLog` class to turn on/off the debug logs in Xcode console.e.g.
  `[OBLLog setTwitterDebug:YES];`

## Usage

####FacebookLibrary:

* You can see the demo code present in SampleFacebookCode Folder, (https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode) .

#####Initial setup:

1. Create app on Facebook.
2. Make changes in your project's .plist file : Add FacebookAppID, FacebookDisplayName. Also create new row URL types, under that create URL Schemes and add value fb{FacebookAppID}.
3. Download and include Library folder inside project.
4. Call handleOpenUrl:url from your main application method application:openURL:sourceApplication:annotation: of UIApplicationDelegate... for handling incoming url like 
```
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // Note this handler block should be the exact same as the handler passed to any open calls.
    return [OBLFacebookLogin handleOpenUrl:(NSURL *)url];
}
```
  - Also call applicationActiveHandle from your main application method applicationDidBecomeActive:application for updating session info like `[OBLFacebookLogin applicationActiveHandle];`
```
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [OBLFacebookLogin applicationActiveHandle];
}
```
#####Using FacebookLibrary:
* Refer this file **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** of FacebookSampleCode to understand how to use FacebookLibrary. Check sample calls to FacebookLibrary present in the code.

Login/Logout:

  - Call any login class method of `OBLFacebookLogin`.

  - Refer `login` method in **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** file

  - For logout call `logout` mehod of `OBLFacebookLogin`:
```
    [OBLFacebookLogin logout];
```
  - Refer `logout` method in **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** file

Request new permission:

  - Refer `request` method in **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** file

Fetch user's data:

  - Refer `fatchDetails` method in **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** file

Post on user's wall:

  - Refer `post` method in **[FacebookViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleFacebookCode/SampleFacebookCode/Controller/FacebookViewController.m)** file

####Google+ Library:

* You can see the demo code present in SampleGoogle+Code Folder (https://github.com/jeneena-obl/SocialPluginsiOS/tree/beta/SampleGoogle%2BCode)

#####Initial setup:

1. In the Google APIs Console, create an APIs Console project, enable the Google+ API then create and get a client ID.(Note:Keep Bundle ID of Xcode project and  APIs Console project same).Follow Step 1. Creating the APIs Console project from this link (https://developers.google.com/+/mobile/ios/getting-started) .
2. Download and include Library folder inside project.
3. Include the following frameworks in your Xcode project:
      AddressBook.framework,
      AssetsLibrary.framework,
      Foundation.framework,
      CoreLocation.framework,
      CoreMotion.framework,
      CoreGraphics.framework,
      CoreText.framework,
      MediaPlayer.framework,
      Security.framework,
      SystemConfiguration.framework,
      UIKit.framework.
4. Add the ObjC linker flag to the app target's build settings:
      Other Linker Flags: -ObjC
5. Add a URL type
    In your app's Info tab, add a URL type and enter your bundle ID as the identifier and scheme.
6. Call `handleURL:sourceApplication:annotation:` from your main application method `application:openURL:sourceApplication:annotation:` of UIApplicationDelegate for handling incoming url.
```
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[OBLGooglePlusLogin sharedInstance] handleURL:url
                                        sourceApplication:sourceApplication
                                               annotation:annotation];
}
```

#####Using Google+Library:
* Refer the file **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** of SampleGoogle+Code to understand how to use Google+Library. Check calls to Google+Library from the sample code.

Login:

  - For login, call `login` method of `OBLGooglePlusLogin`.

  - Refer `login` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance] login];
```
  - Impelement delegate method `finishedWithLogin` of OBLGooglePlusLogin protocol to know whether login is successful or not by declaring your view controller to implement <OBLGooglePlusLogin> and setting delgate of OBLGooglePlusLogin to self.
``` 
- (void) finishedWithLogin:(NSError *)error;
``` 
Fetch user's data:

  - Refer `profileButtonClicked` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
```
[OBLGooglePlusQuery fetchProfileDetailOfUser:^(OBLGooglePlusUser *user, NSError *error){
    //use OBLGooglePlusUser *user to get profile information of user.
    //eg: user.name , user.birthdate ,etc
}];
```
Fetch user's friends profile data:

  - Refer `friendsprofileButtonClicked` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
```
[OBLGooglePlusQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *friends, NSError *error) {
    //use NSArray *friends to get profile details of individual friend
    //eg : for(OBLGooglePlusFriend *friend in friends)
    //     {
    //         NSLog(@"Name:%@",friend.name);
    //     }
}];
```
Share a post:
  - Refer `shareButtonClicked` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
  - For basic sharing with a simple text,the following method can be used 
```
 [[OBLGooglePlusShare sharedInstance] shareStatus:@"Check it out!!"];
```
  - For basic sharing with a simple textand URL,the following method can be used 
```
 [[OBLGooglePlusShare sharedInstance] shareStatus:@"Check it out!!"  withURL:@"http://example.com"];
```
  - For interactive sharing,there are two methods.Either use the method with parameters like title,description,imageURL or the method with parameter URL(it automatically puts image and title from given URL) of your app and CallToActionButtonLabel.A list of valid labels are given in class CallToActionButtonLabels class.This method sets a contentDeepLinkID by itself,so for handling incoming URL,make some changes in AppDelegate.m
```
 [[OBLGooglePlusShare sharedInstance] shareInteractivePost:@"Get cool apps from Object Lounge!"
                                                 withTitle:@"Object Lounge Technologies"
                                            addDescription:@"Object Lounge is a Miami based mobile strategy and   application development firm"
                                               andImageURL:nil];
```
```
 [[OBLGooglePlusShare sharedInstance] shareInteractivePost:@"Get cool apps from Object Lounge!"
                                                   withURL:@"http://www.objectlounge.com" 
                                     withCallToActionLabel:JOIN]
```
  - When the app launches, it needs to check if the deep-link information is available and launch the correct view in the app.So,follow these steps:

  1.In your app delegate's .h file, import GooglePlus/GooglePlus.h, and add the GPPDeepLinkDelegate protocol
```
 @interface AppDelegate : UIResponder <UIApplicationDelegate, GPPDeepLinkDelegate>
```
  2.In your app delegate's applicationDidFinishLaunching:withOptions method, set the GPPDeepLink's delegate, and check for incoming deep links by calling readDeepLinkAfterInstall:
```
- (BOOL)application: (UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
    [GPPDeepLink setDelegate:self];
    [GPPDeepLink readDeepLinkAfterInstall];
    return YES;
}
```
  3.To process incoming deep-link URLs, call GPPURLHandler's handleURL method from app delegate's URL handler.
```
- (BOOL)application: (UIApplication *)application
             openURL: (NSURL *)url
   sourceApplication: (NSString *)sourceApplication
          annotation: (id)annotation 
{
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}
```
  4.Handle the incoming deep link in your app delegate by implementing the didRedceiveDeepLink method, which is part of     the GPPDeepLinkDelegate protocol. This method is where you can perform any application logic based on the deep-link       identifier that the app receives.
```
- (void)didReceiveDeepLink: (GPPDeepLink *)deepLink 
{
    // An example to handle the deep link data.
    UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"Deep-link Data"
                                                     message:[deepLink deepLinkID]
                                                    delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [alert show];
}
```
  - To know the status whether posts are shared,declare that your view controller implements the OBLGooglePlusShareDelegate  protocol. In `shareButtonClicked` set delegate of OBLGooglePlusShare  to self. Implement the method `sharingCompleted`
```
-(void) sharingCompleted:(BOOL)shared
{
    //check sharing was successful or not, based on (BOOL) shared.
}
```
Logout :
  - For logout, call `logout` method of `OBLGooglePlusLogin`.
 
  - Refer `logout` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance ]logout];
```
Disconnect :
  - For disconnect, call `disconnect` method of `OBLGooglePlusLogin`.
 
  - Refer `disconnect` method in **[GooglePlus_ViewController.m](https://github.com/jeneena-obl/SocialPluginsiOS/blob/beta/SampleGoogle%2BCode/GooglePlusDemo/Controller/GooglePlus_ViewController.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance ]disconnect];
```
  - Implement delegate method `didDisconnectWithError`  of OBLGooglePlusLogin protocol to know whether the user is disconnected successfully or not.
``` 
- (void)didDisconnectWithError:(NSError *)error
{
    //check whether disconnected properly or not, based on error value.
}
``` 
####Twitter Library:


#####Initial setup:

1. Create app on Twitter at **[https://apps.twitter.com/](https://apps.twitter.com/)**. Copy your consumr key and secret for that app. See **[Tutorial on how to create app](http://themepacific.com/how-to-generate-api-key-consumer-token-access-key-for-twitter-oauth/994/)** for more detail.
2. Download and include Library folder inside project.

#####Using Twitter Library:
* Refer this file **[OBLViewController.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/TwitterDemo/OBLTwitterDemo/OBLViewController.m)** of TwitterDemo to understand how to use Twitter Library.

- Login:
  ```
  // Set consumer key and secret
  [OBLTwitterLogin setConsumerKey:@"YOUR_CONSUMER_KEY" secret:@"YOUR_CONSUMER_SECRET"];
        
  // Present login screen
  OBLTwitterLoginViewController * loginController = [[OBLTwitterLoginViewController alloc] init];
        
  // Set appropriate delegate to handle login completion event
  loginController.loginDelegate = self;
  // Present screen for login
  [self presentViewController:loginController animated:YES completion:nil];
  ```

- Logout:
  ```
  // Get OBLTwitter instance
  OBLTwitter * twitter = [OBLTwitter sharedInstance];
  [twitter logout];
  ```

- Tweet:
  ```
  // Set consumer key and secret
  [OBLTwitterLogin setConsumerKey:@"YOUR_CONSUMER_KEY" secret:@"YOUR_CONSUMER_SECRET"];
    
  // Get OBLTwitter instance
  OBLTwitter * twitter = [OBLTwitter sharedInstance];
    
  // Call method to tweet. It returns `NSError` if tweet not successful.
  NSError * error = [twitter tweet:@"Hey, I am tweetting."];
  ```
