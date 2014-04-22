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
2. Open your project in Xcode, then drag and drop Library folders(as mentioned below) that you need onto your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
  - Add Protocol and Utility folder
  - Add FacebookLibrary for Facebook integration
  - Add Google+ Library for Google+ integration
  - Add OBLTwitterLibrary for Twitter integration

3. Include library files wherever you need it like `#import "OBLFacebookogin.h"` for Facebook.

## APIs documentation

####FacebookLibrary:

You can see the demo code present in SampleFacebookCode Folder.

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
  - Main class having all profile information of Facebook user

* `OBLFacebookFriend`
  - Refer to **[OBLFacebookFriend.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/FacebookLibrary/OBLFacebookFriend.h)**
  - Class having all profile information of Facebook friend

Log (Debug):

* `OBLLog`
  - Refer to **[OBLLog.h](https://github.com/ObjectLounge/SocialPluginsiOS/blob/beta/Library/Utility/OBLLog.h)**
  - Call this class and set facebookDebug to YES to turn on the error logs like `[OBLLog setFacebookDebug:YES];`

####Google+ Library:

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

* You can see the demo code present in SampleFacebookCode Folder.

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