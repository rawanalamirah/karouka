//
//  profile.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import SwiftUI

struct profile: View {
    
    @State private var userImage: Image = Image(systemName: "person.circle.fill")

    var body: some View {
        VStack {
            // Profile Picture
            userImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                .padding(.top, 20)

            // User Information
            Text(user.MOCK_USER.fullname)
                .font(.title)
                .padding()

            Text(user.MOCK_USER.email)
                .font(.headline)
                .padding()

            // Additional User Details
            // Add more Text views to display other user information

            Spacer()

            // Edit Profile Button
            Button(action: {
                // Handle edit profile action
            }) {
                Text("Edit Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
    }
}

