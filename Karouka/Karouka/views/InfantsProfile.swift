//
//  InfantsProfile.swift
//  Karouka
//
//  Created by Rawan Alamirah on 23/11/2023.
//

import SwiftUI

struct InfantsProfile: View {
    @EnvironmentObject var infantProfileViewModel: InfantProfileViewModel
    @State private var isEditing = false
    @State private var updatedWeight = ""
    @State private var updatedAge = ""
    @State private var updatedBloodType = ""
    @State private var isSaving = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Health Information")) {
                    HStack {
                        Text("Weight:")
                        Spacer()
                        if isEditing {
                            TextField("Enter weight", text: $updatedWeight)
                        } else {
                            Text(infantProfileViewModel.infant?.weight ?? "")
                        }
                    }
                    HStack {
                        Text("Age:")
                        Spacer()
                        if isEditing {
                            TextField("Enter age", text: $updatedAge)
                        } else {
                            Text(infantProfileViewModel.infant?.age ?? "")
                        }
                    }
                    HStack {
                        Text("Blood Type:")
                        Spacer()
                        if isEditing {
                            TextField("Enter blood type", text: $updatedBloodType)
                        } else {
                            Text(infantProfileViewModel.infant?.bloodType ?? "")
                        }
                    }
                    // Include other fields as needed
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
                        isSaving = true

                        DispatchQueue.main.async {
                            infantProfileViewModel.updateInfantProfile(
                                weight: updatedWeight,
                                age: updatedAge,
                                bloodType: updatedBloodType
                                // Pass other updated fields
                            )
                            isSaving = false
                            isEditing = false
                        }
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                    })
                    .disabled(isSaving)
                }
            }
            .padding()
        }
        .background(Color(red: 265/255, green: 190/255, blue: 230/255).opacity(0.4))
    }
}





#Preview {
    InfantsProfile()
}
