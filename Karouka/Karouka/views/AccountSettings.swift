//
//  AccountSettings.swift
//  Karouka
//
//  Created by Rawan Alamirah on 23/11/2023.
//

import SwiftUI

struct AccountSettings: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var hidepass = true
    @State private var isEditing = false
    @State private var updatedFullname = ""
    @State private var updatedInfant = ""
    @State private var updatedCribID = ""
    @State private var updatedEmail = ""
    @State private var updatedPassword = ""
    
    var body: some View {
        VStack {
            if let user = viewModel.currentUser {
                VStack {
                    Form {
                        Section(header: Text("Personal Information")) {
                            HStack {
                                Text("Full name:")
                                Spacer()
                                if isEditing {
                                    TextField("Enter full name", text: $updatedFullname)
                                } else {
                                    Text(user.fullname)
                                }
                            }
                            HStack {
                                Text("Baby's Name:")
                                Spacer()
                                if isEditing {
                                    TextField("Enter baby's name", text: $updatedInfant)
                                } else {
                                    Text(user.infant)
                                }
                            }
                            HStack {
                                Text("Crib's ID")
                                Spacer()
                                if isEditing {
                                    TextField("Enter crib's ID", text: $updatedCribID)
                                } else {
                                    Text(user.cribID)
                                }
                            }
                            HStack {
                                Text("Email:")
                                Spacer()
                                Text(user.email)
                            }
                            HStack {
                                Text("Password:")
                                Spacer()
                                if isEditing {
                                    SecureField("Enter password", text: $updatedPassword)
                                } else {
                                    ZStack{
                                        Text(user.password)
                                        Rectangle()
                                            .fill(hidepass ? .white : .white.opacity(0))
                                            .onTapGesture {
                                                hidepass.toggle()
                                            }
                                            .frame(width: 100, height: 30)
                                            
                                    }
                                    
                                }
                            }
                        }
                        Button {
                                               viewModel.deleteAccount { result in
                                                   switch result {
                                                   case .success:
                                                       // Handle successful account deletion
                                                       print("Account deleted successfully")
                                                   case .failure(let error):
                                                       // Handle failure, display error to user or perform necessary action
                                                       print("Error deleting account: \(error.localizedDescription)")
                                                   }
                                               }
                                           } label: {
                                               Text("Delete Account")
                                                   .foregroundColor(.red)
                                                   .font(.subheadline)
                                           }
                    }
                    .disabled(!isEditing)
                    
                    HStack {
                        Button(action: {
                            isEditing.toggle()
                        }, label: {
                            Text(isEditing ? "Cancel" : "Edit")
                                .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                        })
                        
                        if isEditing {
                            Button(action: {
                                Task {
                                    do {
                                        if !updatedFullname.isEmpty {
                                            try await viewModel.updateFullname(fullname: updatedFullname)
                                        }
                                        if !updatedInfant.isEmpty {
                                            try await viewModel.updateInfant(infant: updatedInfant)
                                        }
                                        if !updatedCribID.isEmpty {
                                            try await viewModel.updateCribID(cribID: updatedCribID)
                                        }
                                        if !updatedEmail.isEmpty {
                                            try await viewModel.updateEmail(newEmail: updatedEmail)
                                        }
                                        if !updatedPassword.isEmpty {
                                            try await viewModel.updatePassword(newPassword: updatedPassword)
                                        }
                                        isEditing.toggle()
                                    } catch {
                                        print("Error updating user: \(error.localizedDescription)")
                                    }
                                }
                            }, label: {
                                Text("Save")
                                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                            })
                        }
                    }
                    .padding()
                }
            }
        }.background(Color(red: 265/255, green: 190/255, blue: 230/255).opacity(0.4))
    }
}



#Preview {
    AccountSettings()
}
