//
//  WelcomePage.swift
//  Karouka
//
//  Created by rawan alamirah on 29/09/2023.
//

import SwiftUI
import Firebase

struct WelcomePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingScanner = false
        @State private var scannedCribID: String = ""
        @State private var navigateToSignup = false

    
    var body: some View {
        NavigationView{
        VStack {
            Image("cribtoy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 70)
                .padding(.top, 35)

//            Text("KAROUKA")
//                .font(.custom("Avenir-Heavy", size: 45))
//                .fontWeight(.bold)
//                .foregroundColor(.purple)
//                .padding(.top, 20)
//
            Image("karouka")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
                .padding(.top)

            ZStack {
                Text("      Smart, Safe, and Secure: \nKarouka for your peace of mind")
        .font(.custom("Avenir-Medium", size: 20).bold())
                    .foregroundColor(.pink.opacity(0.6))
                .padding(.top, 10)
                Text("      Smart, Safe, and Secure: \nKarouka for your peace of mind")
        .font(.custom("Avenir-Medium", size: 20).bold())
                    .foregroundColor(.purple.opacity(0.3))
                .padding(.top, 10)
            }.padding(.bottom, 80)
            
            NavigationLink(destination: signup(cribID: "")) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(Color(red: 190/255, green: 150/255, blue: 255/255))
                    .cornerRadius(15)
            }
            .padding(.bottom, 15)
            
            NavigationLink(destination: login()) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(Color(red: 190/255, green: 150/255, blue: 255/255))
                    .cornerRadius(15)
            }
            
            Spacer()
                            
//            Button(action: {
//                                isShowingScanner.toggle()
//                            }) {
//                                Text("Pair with Crib")
//                                    .font(.caption)
//                                    .foregroundColor(.blue)
//                            }
//                            .padding(.bottom, 15)
//                            .sheet(isPresented: $isShowingScanner) {
//                                QRCodeScannerView { result in
//                                    scannedCribID = result
//                                    isShowingScanner = false // Close the scanner after obtaining the cribID
//                                    navigateToSignup = true // Navigate to Signup after obtaining the cribID
//                                }
//                            }
                            

                            Spacer()
        }.ignoresSafeArea()

            
        }.navigationBarBackButtonHidden(true)
}
//    func showCameraAccessAlert() {
//            let alert = UIAlertController(
//                title: "Camera Access",
//                message: "This feature requires access to your camera to scan QR codes.",
//                preferredStyle: .alert
//            )
//            
//            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//                isShowingScanner = true
//            })
//            
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            
//            // Present the alert
//            // (For SwiftUI, you might use an appropriate way to present UIAlertControllers)
//        }
}
struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
