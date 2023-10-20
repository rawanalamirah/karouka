//
//  profile.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import SwiftUI

struct profile: View {
    @EnvironmentObject var viewModel : AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                // Profile Picture
                Text(user.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .background(Color(.lightGray))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    

                // User Information
                Text(user.fullname)
                    .font(.title)
                    .padding()

                Text(user.email)
                    .font(.headline)
                    .padding()

                // Additional User Details
                // Add more Text views to display other user information

                Spacer()

                // sign out button
                Button{
                    viewModel.signOut()
                } label:{
                    Text("sign out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
                .padding()

                // Edit Profile Button
                Button{

                } label: {
                    Text("Edit Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
                .padding()
            }

        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
    }
}

