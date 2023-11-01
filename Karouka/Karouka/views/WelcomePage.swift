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
    var body: some View {
        NavigationView{
        VStack {
            Image("cribtoy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 70)
                .padding(.top, 35)

            Text("KAROUKA")
                .font(.custom("Avenir-Heavy", size: 45)) 
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.top, 20)
            
            Image("crib")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
                .padding(.top, -20)

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
            
            NavigationLink(destination: signup()) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(.purple)
                    .cornerRadius(15)
            }
            .padding(.bottom, 15)
            
            NavigationLink(destination: login()) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(.purple)
                    .cornerRadius(15)
            }
            
            Spacer()
        }.ignoresSafeArea()

            
        }.navigationBarBackButtonHidden(true)
}
}
struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
