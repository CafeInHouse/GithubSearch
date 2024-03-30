//
//  GithubSearchAppApp.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/29/24.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        Task {
            #if Develop
            await ServiceApp.inject(phase: .develop)
            #else
            await ServiceApp.inject(phase: .product)
            #endif
        }
        
        return true
    }
}

@main
struct GithubSearchAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: MainViewModel())
        }
    }
}
