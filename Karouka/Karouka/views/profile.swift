//
//  profile.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import SwiftUI
import Firebase

struct profile: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var AccountSetting = false
    @State private var InfantProfile = false


    var body: some View {
        if let user = viewModel.currentUser {
        ZStack {
            Color(red: 265/255, green: 190/255, blue: 230/255).opacity(0.4)
            VStack {
                // Profile Picture
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .frame(width: 80, height: 80)
                        .background(Color(.lightGray))
                        .clipShape(Circle())
                        .padding(.trailing, 30)
                    
                    VStack (alignment: .leading){
                // User Information
//                Text("Rawan Alamirah")
                        Text("\(user.infant)'s Karouka")
                            .font(.system(size: 25))

//                Text("rawanalamirah@hotmail.com")
                  Text("#\(user.cribID)")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding(.top, -5)
                }
                }
                .padding()
                .frame(width: 390, height: 130, alignment: .center)
                .background(Color(.white))
                .cornerRadius(25)
                .padding(.bottom, 100)
//                Spacer()
                
                VStack {
                    HStack {
                        Text("Options")
                            .bold()
                            .font(.system(size: 25))
                        Spacer()
                            
                    }
                    Divider()
                    HStack {
                    Image(systemName: "person.crop.circle")
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                            .clipShape(Circle())

                    Text("Account Setting")
                            .font(.system(size: 20))
                    Spacer()
                    Image(systemName: "chevron.right")
                    }.onTapGesture(perform: {AccountSetting.toggle()})
                    .sheet(isPresented: $AccountSetting, content: {AccountSettings()})
                    
                    Divider()
                    HStack {
                        Image(systemName: "bandage")
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                .clipShape(Circle())
                        
                    Text("Infant's Profile")
                            .font(.system(size: 20))

                    Spacer()
                    Image(systemName: "chevron.right")
                    }.onTapGesture(perform: {InfantProfile.toggle()})
                        .sheet(isPresented: $InfantProfile, content: {InfantsProfile()})
                    
                    Divider()
                    HStack {
                        Image(systemName: "bell")
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                .clipShape(Circle())
                        Text("Notifications")
                            .font(.system(size: 20))

                        Spacer()
                        Image(systemName: "chevron.right")
                        }
                    Divider()

                    HStack {
                        Image(systemName: "questionmark.circle")
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                .clipShape(Circle())
                        Text("Help Center")
                            .font(.system(size: 20))

                        Spacer()
                        Image(systemName: "chevron.right")
                            }
                }
                .padding()
                .frame(width: 390, height: 290, alignment: .center)
                .background(Color(.white))
                .cornerRadius(25)
                .padding(.bottom, 60)

                // sign out button
                Button{
                    viewModel.signOut()
                } label:{
                    Text("sign out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                        .cornerRadius(8)
                }
                .background(Color.clear)
                .padding()

                // Edit Profile Button
//                Button{
//
//                } label: {
//                    Text("Edit Profile")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color(red: 180/255, green: 200/255, blue: 255/255))
//                        .cornerRadius(8)
//                }
//                .padding()
            }
        }.ignoresSafeArea()

        }
//        Button{
//            viewModel.signOut()
//        } label:{
//            Text("sign out")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color(red: 180/255, green: 200/255, blue: 255/255))
//                .cornerRadius(8)
//        }
//        .padding()

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
            .environmentObject(AuthViewModel())
    }
}

