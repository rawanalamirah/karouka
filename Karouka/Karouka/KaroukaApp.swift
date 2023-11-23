//
//  KaroukaApp.swift
//  Karouka
//
//  Created by rawan alamirah on 26/09/2023.
//

import SwiftUI
import Firebase

@main
struct KaroukaApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var activityManager = ActivityManager()
    @StateObject var infantProfileViewModel = InfantProfileViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(activityManager)
                .environmentObject(infantProfileViewModel)
                
        }
    }
}
