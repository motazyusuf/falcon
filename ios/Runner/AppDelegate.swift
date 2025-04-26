import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Add this method to handle URL opening
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Try to let Flutter plugins handle the URL first
        let handledByFlutterPlugins = super.application(app, open: url, options: options)

        // If Flutter plugins handled it, return true
        if handledByFlutterPlugins {
            return true
        }

        // ---- Optional: Add any custom native handling for URLs here if needed ----
        // If you have specific native logic for certain URLs that Flutter shouldn't handle,
        // you could add checks here. For typical deep linking with packages like app_links,
        // letting Flutter handle it via the superclass call is usually sufficient.
        // print("URL not handled by Flutter plugins: \(url.absoluteString)")

        // Return false if the URL wasn't handled by Flutter or custom native code
        return false
    }
}
