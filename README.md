# Find the notification service file in /lib

# For AndroidInitializationSettings pass the image file name (flutter_logo) and make sure to add this image file inside android/app/src/main/res/drawable folder.

# Setup android/app build.gradle with the commented instructions
# Setup android manifest with the commented instructions

# In order to complete the iOS setup for getting notification, we need to add the following lines inside iOS/Runner/ApDelegate.swift file

```
import UIKit
import Flutter

//----------#1----------
import flutter_local_notifications
//----------------------

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

//----------#2----------
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)}
//----------------------
    GeneratedPluginRegistrant.register(with: self)

//----------#3----------
      if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
//----------------------

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```