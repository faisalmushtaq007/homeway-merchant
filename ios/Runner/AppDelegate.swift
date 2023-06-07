import UIKit
import Flutter
import flutter_background_executor

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    SwiftFlutterBackgroundExecutorPlugin.taskIdentifier = "com.homemakers.merchant.source_language_download.task"
    SwiftFlutterBackgroundExecutorPlugin.taskIdentifier = "com.homemakers.merchant.target_language_download.task"
    SwiftFlutterBackgroundExecutorPlugin.taskIdentifier = "com.homemakers.merchant.new_language_download.task"
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
