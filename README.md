SocialPluginsiOS
================

Social media plugins for iOS

Introduction
------------

SocialPluginsiOS provides integration with Facebook, Google+ and Twitter for iOS Applications in the simplest and easiest possible way.

It has different libraries for Facebook, Google+ and Twitter, so you can use any of them or all at the same time.

## Features

Facebook Library:
* Login/Logout with facebook in your application. (with different permissions)
* Fetch facebook user's profile.
* Request for additional facebook permissions.
* Post feed status in user's wall.
* Fetch facebook user's friends and their profile.
* Provides functinality to turn debugging ON or OFF (Log message makes easy to locate error).

Google+ Library:
* Sign in and Sign out with Google+ in your application
* Share posts with friends
* Fetch signed in user's profile details.
* Fetch user's Google+ friend's profile information.
* Provides functionality of debugging.Logging messages can be activated/Deactivated by setting ON or OFF on setGooglePlusDebug.
 
Twitter Library:

## Requirements 

* iOS 6.1 through iOS 7.0 or later.
* ARC memory management.

## Adding library to project

### Source files

steps to include library to project:

1. Download the Library folder from (https://github.com/ObjectLounge/SocialPluginsiOS).
2. Open your project in Xcode, then drag and drop Library folders(as mentioned below) that you need in your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
  - Add Protocol and Utility folder
  - Add FacebookLibrary for facebook integration
  - Add Google+ Library for Google+ integration
  - Add TwitterLibrary for Twitter integration

3. Include library files wherever you need it like `#import "OBLFacebookogin.h"`.

## APIs documentation

####FacebookLibrary:

You can see the demo code present in SampleFacebookCode Folder.

Login/Logout:
* `OBLFacebookLogin`
  - Refer to **[OBLFacebookLogin.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookLogin.h)**
  - FacebookLoging class provide basic utilities for the facebook like login, logout, loging with permissions.
  - Request new read or publish permission.
  - User has to call handleOpenUrl:url in the application:openURL:sourceApplication:annotation: of UIApplicationDelegate... for handling incoming url like `[OBLFacebookLogin handleOpenUrl:(NSURL *)url];`
  - Also call applicationActiveHandle in applicationDidBecomeActive:application for updating session info like `[OBLFacebookLogin applicationActiveHandle];`

* `OBLFacebookPermission`
  - Refer to **[OBLFacebookPermission.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookPermission.h)**
  - List all the Facebook Permissions that can be used with this library.

Social media query (Fetch data):

* `OBLFacebookQuey`
  - Refer to **[OBLFacebookQuery.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookQuery.h)**
  - Class fetches the user and user's friends' profile.

Social media posting:

* `OBLFacebookPost`
  - Refer to **[OBLFacebookPost.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookPost.h)**
  - This class allows user to post on user's wall.


Profile details:

* `OBLFacebookUser`
  - Refer to **[OBLFacebookUser.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookUser.h)**
  - Main class having all profile information of facebook user

* `OBLFacebookFriend`
  - Refer to **[OBLFacebookFriend.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookFriend.h)**
  - Class having all profile information of facebook friend

Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Call this class and set facebookDebug to YES to turn on the error logs like `[OBLLog setFacebookDebug:YES];`

####Google+ Library:

You can check the demo code present in SampleGoogle+Code Folder.

Login/Logout:
* `OBLGooglePlusLogin`
  - Refer to **[OBLGooglePlusLogin.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusLogin.h)**
  - This class provides functionalities such as login, logout and disconnect for google+ users.
  - Before calling the methods like [ login ], set clientID which can be obtained from Google APIs Console by creating an APIs Console project, enabling the Google+ API and then by creating a client ID.Also set scopes and actions, shouldFetchGoogleUserEmail, shouldFetchGoogleUserID, shouldFetchGooglePlusUser (optional) as required.
  - There are delegates such as finishedWithLogin,didDisconnectWithError to be implemented which gives notification about successful completion of process or error if any.
  - Call the URL handler [ handleURL:sourceApplication:annotation:] from app delegate's URL handler  [ application:openURL:sourceApplication:annotation:]. This handler will properly handle the URL that your application receives at the end of the authentication process.

Social media query (Fetch data):

* `OBLGoogelPlusQuey`
  - Refer to **[OBLGoogelPlusQuey.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGoogelPlusQuey.h)**
  - This class fetches the user and user's friends profile information.

Social media posting:

* `OBLGooglePlusShare`
  - Refer to **[OBLGooglePlusShare.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusShare.h)**
  - This class allows users to share posts.


Profile details:

* `OBLGooglePlusUser`
  - Refer to **[OBLGooglePlusUser.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusUser.h)**
  - This class has profile information of signed in user.

* `OBLGooglePlusFriend`
  - Refer to **[OBLGooglePlusFriend.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Google+Library/OBLGooglePlusFriend.h)**
  - This class has information of signed in user's friends profile detail.

Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Call this class and set googlePlusDebug to YES to turn on the error logs .Eg: `[OBLLog setGooglePlusDebug:YES];`
  - Use methods like [ logGPMessage ] to log any message and  [ GPErrorLog ] to log any specific error messages.

####Twitter Library:


## Usage

####FacebookLibrary:

* You can see the demo code present in SampleFacebookCode Folder.

#####Initial setup:

1. Create app on facebook.
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

* You can see the demo code present in SampleGoogle+Code Folder.

#####Initial setup:

1. In the Google APIs Console,create an APIs Console project, enable the Google+ API then create and get a client ID.(Note:Keep Bundle ID of Xcode project and  APIs Console project same)
2. Include the following frameworks in your Xcode project:
      AddressBook.framework
      AssetsLibrary.framework
      Foundation.framework
      CoreLocation.framework
      CoreMotion.framework
      CoreGraphics.framework
      CoreText.framework
      MediaPlayer.framework
      Security.framework
      SystemConfiguration.framework
      UIKit.framework
2. Download and include Library folder inside project.
3. Add the ObjC linker flag to the app target's build settings:
      Other Linker Flags: -ObjC
4. Add a URL type
    In your app's Info tab, add a URL type and enter your bundle ID as the identifier and scheme.
4. Call [ handleURL:sourceApplication:annotation: ] from your main application method [ application:openURL:sourceApplication:annotation: ] of UIApplicationDelegate... for handling incoming url like 
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
* Refer this file **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** of SampleGoogle+Code to understand how to use Google+Library. Check calls to Google+Library from the sample code.

Login/Logout and Disconnect:

  - For login, call `login` method of `OBLGooglePlusLogin`.

  - Refer `login` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance] login];
```
  - For logout, call `logout` method of `OBLGooglePlusLogin`.
 
  - Refer `logout` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance ]logout];
```
  - For disconnect, call `disconnect` method of `OBLGooglePlusLogin`.
 
  - Refer `disconnect` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
    [[OBLGooglePlusLogin sharedInstance ]disconnect];
```
Fetch user's data:

  - Refer `profileButtonClicked` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
    [OBLGooglePlusQuery fetchUserProfileWithCompletionHandler:^(OBLGooglePlusUser *result, NSError *error){ 
      //code
     }];
```
Fetch user's friends profile data:

  - Refer `profileButtonClicked` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
    [OBLGooglePlusQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error) {
      //code
     }];
```
Post on user's wall:

  - Refer `shareButtonClicked` method in **[CheckingVC.m](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/SampleGoogle+Code/GooglePlusDemo/Controller/CheckingVC.m)** file.
```
 [[OBLGooglePlusShare sharedInstance] shareStatus:@"Check it out!!"
                                        withTitle:@"blah..blah.."
                                   addDescription:@"blahhh.blahh"
                                      andImageURL:nil
                                           andURL:@"https://www.examplecode.com"];
```
####Twitter Library:
