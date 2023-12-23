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
    @StateObject var patientModel = PatientDataViewModel()
    //    @Environment(\.openURL) var openURL
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(activityManager)
                .environmentObject(infantProfileViewModel)
                .environmentObject(patientModel)
            //                .onOpenURL { url in
            //                                    handleURL(url)
            //                                }
            
        }
    }
    //    private func handleURL(_ url: URL) {
    //            // Extracting components from the URL
    //            let scheme = url.scheme ?? ""
    //            let host = url.host ?? ""
    //            let path = url.path
    //
    //            // You can also extract query parameters if needed
    //            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
    //            let someParameter = queryItems?.first(where: { $0.name == "someParameter" })?.value
    //
    //            // Handling based on URL components
    //            if scheme == "myapp" {
    //                switch host {
    //                case "signup":
    //                    NavigationLink("", destination: signup(cribID: ""))
    //                    break
    ////                case "profile":
    ////                    // Code to handle profile view navigation
    ////                    if let userId = someParameter {
    ////                        // Handle the user ID for profile page
    ////                    }
    ////                    break
    ////                // Handle other hosts or paths as needed
    //                default:
    //                    break
    //                }
    //            }
    //        }
}
