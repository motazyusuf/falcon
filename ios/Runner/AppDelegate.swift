import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
         if #available(iOS 10.0, *) {
           UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
         }
         GeneratedPluginRegistrant.register(with: self)
         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
         }
             @available(iOS 10.0, *)
             @objc override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
               print("Foreground notification received with title: \(notification.request.content.title)")
               completionHandler([.alert, .badge, .sound])
             }
       }