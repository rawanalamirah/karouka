//
//  login.swift
//  Karouka
//
//  Created by rawan alamirah on 29/09/2023.
//

import SwiftUI

struct login: View {
    @State var email: String = ""
    @State var pass: String = ""
    @State var remember: Bool = true

    
    var body: some View {
        VStack {
            Image("cribtoy") // Replace "baby_image" with your baby image asset name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 200)
            .padding(.top, 35)
            
            Spacer()
            
            Text("Log in")
                .font(.custom("Avenir-Medium", size: 30).bold())
                .frame(width: 350, height:50 , alignment: .topLeading)
            
            Text("Enter your details to continue")
                .font(.custom("Avenir-Medium", size: 20).bold())
                .frame(width: 350, alignment: .leading)
            
            Spacer()
            
            VStack {
                Text("Enter You E-mail")
                    .font(.custom("Avenir-Medium", size: 12))
                    .bold()
                .frame(width: 350,alignment: .leading)
                TextField("wx.yz@email.com", text: $email)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.all, 10)
        
            VStack {
                Text("Enter You Password")
                    .font(.custom("Avenir-Medium", size: 12))
                    .bold()
                .frame(width: 350,alignment: .leading)
                TextField("..........", text: $email)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.all, 10)
            
            HStack {
                Toggle("Remember Me", isOn: $remember)
                    .toggleStyle(.switch)
                    .padding()
                
                Spacer()
                
                Text("Recover Password")
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            
            NavigationLink(destination: login()) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(.purple.opacity(0.5))
                    .cornerRadius(15)
            }

                
                            
         Spacer()
        }.ignoresSafeArea()
            
            }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
