//
//  sheetView.swift
//  Karouka
//
//  Created by rawan alamirah on 01/11/2023.
//

import SwiftUI


struct sheetView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var name = ""
    @State private var notes = ""
    let icon : Image
    let title : String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                    .padding(.leading, 10)
                Spacer()
                icon
                    .resizable()
                    .padding(.bottom, 5)
                    .padding(.trailing, 5)
                    .padding(.leading, 5)
                    .padding(.top, 5)
                    .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                    .frame(width: 70, height: 60, alignment: .center)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                
            }
            Spacer()
            if let user = viewModel.currentUser {
            HStack {
                Text("Hello \(user.fullname)!")
                    .font(.system(size:35 ))
                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                Spacer()
            }.padding(.leading)
            }

                Text("Looks Like you want to \(title)")
                    .font(.title2)
                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
            Spacer()

//            InputView(text: $name, title: "Enter Caregiver name:", placeholder: "Caregiver")
//                .disableAutocorrection(true)
//                .autocapitalization(.words).padding(.leading)
            
//            InputView(text: $notes, title: "Enter notes if any:", placeholder: "write notes here")
//                .padding(.leading)
//                .disableAutocorrection(true)
            
            Text("Do you have any extra notes?")
            TextField("notes", text: $notes)
                .lineLimit(10)
                .padding()
                .frame(minWidth: 300, maxWidth: 300, minHeight: 100, maxHeight: 200, alignment: .topLeading)
//                .clipShape(Rectangle().stroke(.gray, lineWidth: 10))
                .textFieldStyle(.roundedBorder)
                .cornerRadius(10)
            
            Button("Done") {
                dismiss()
            }.padding()
            .padding(.leading)
            .padding(.trailing)
            .background(Color(red: 180/255, green: 200/255, blue: 255/255))
            .cornerRadius(15)
            .foregroundColor(Color(.white))
            
            Spacer()
        }

        
    }
}

struct sheetView_Previews: PreviewProvider {
    static var previews: some View {
        sheetView(icon: Image("diaper"), title: "Diaper Change")
    }
}
