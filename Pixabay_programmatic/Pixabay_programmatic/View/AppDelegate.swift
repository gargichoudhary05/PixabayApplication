
import UIKit
import Intents

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      INPreferences.requestSiriAuthorization { status in
                  if status == .authorized {
                      print("Hey, Siri!")
                  } else {
                      print("Nay, Siri!")
                  }
              }
    return true
  }


}

