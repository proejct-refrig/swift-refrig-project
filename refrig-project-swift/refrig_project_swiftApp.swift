//
//  refrig_project_swiftApp.swift
//  refrig-project-swift
//
//  Created by 이로운 on 4/22/25.
//

import SwiftUI

@main
struct refrig_project_swiftApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(loginViewModel)
                .onOpenURL { url in
                    loginViewModel.handleIncomingURL(url)
                }
        }
    }
}
