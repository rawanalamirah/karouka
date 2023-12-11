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
    @State private var updatedBloodType = ""
    @State private var birthDate = Date()
    @State private var ageInMonths = 0
    @State private var ageInDays = 0
    @State private var isSaving = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Infant Information")) {
                    HStack {
                        Text("Weight:")
                        Spacer()
                        if isEditing {
                            TextField("Enter weight", text: $updatedWeight)
                        } else {
                            Text(infantProfileViewModel.infant?.weight ?? "")
                        }
                    }
                    VStack {
                        HStack {
                            Text("Birth Date:")
                            Spacer()
                            Text("\(formattedDate(birthDate: birthDate))")
                        }
                        if isEditing {
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                                .padding(.leading, 15)
                        }
                    }
                    HStack {
                        Text("Age:")
                        Spacer()
                        if !isEditing {
                            Text("\(ageInMonths) months \(ageInDays) days")
                        } else {
                            Spacer() // Placeholder for alignment
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
                        calculateAge()
                        DispatchQueue.main.async {
                            infantProfileViewModel.updateInfantProfile(
                                weight: updatedWeight,
                                age: "\(ageInMonths) months \(ageInDays) days",
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
        .onAppear {
            calculateAge() // Calculate age initially
        }
    }

    func calculateAge() {
        let calendar = Calendar.current
        let currentDate = Date()

        let components = calendar.dateComponents([.month, .day], from: birthDate, to: currentDate)

        if let months = components.month, let days = components.day {
            ageInMonths = abs(months)
            ageInDays = abs(days)
        }
    }

    func formattedDate(birthDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: birthDate)
    }
}


#Preview {
    InfantsProfile()
}
