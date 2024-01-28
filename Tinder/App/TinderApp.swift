//
//  TinderApp.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TinderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var userManager = UserManager(service: MockUserService())
    @StateObject var authmanager = AuthManager(service: MockAuthService())
    @StateObject var matchManager = MatchManager(service: MatchService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager)
                .environmentObject(authmanager)
                .environmentObject(matchManager)
        }
    }
}
