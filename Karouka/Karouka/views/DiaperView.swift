//
//  sheetView.swift
//  Karouka
//
//  Created by rawan alamirah on 01/11/2023.
//

import SwiftUI
import Firebase


struct DiaperView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @EnvironmentObject var activityManager : ActivityManager
    @State private var name = ""
    @State private var notes = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Diaper Change")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    Spacer()
                    Image("diaper")
                        .resizable()
                        .padding(.bottom, 5)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                        .padding(.top, 5)
                        .frame(width: 80, height: 80, alignment: .center)
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                    
                }
//                Spacer()
    //            if let user = viewModel.currentUser {
                HStack {
    //                Text("Hello \(user.fullname)!")
                    Text("Hello There!")
                        .font(.system(size:35))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading)

                    Text("Looks Like you want to Change Diapers")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 380, height: 100, alignment: .topLeading)
                Spacer()
                

                
                VStack {
                Text("Enter Your name please:")
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                TextField("Caregivers name", text: $name)
                    .padding()
                    .frame(width: 260, height: 50, alignment: .topLeading)
                Divider()
                }.frame(width: 260)
                Text("Do you have any extra notes?")
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                TextField("notes", text: $notes)
                    .lineLimit(10)
                    .padding()
                    .frame(minWidth: 300, maxWidth: 300, minHeight: 100, maxHeight: 200, alignment: .topLeading)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                
                Button("Done") {
                    activityManager.addAct(id: Int.random(in: 1...10000), name: name, icon: "diaper", type: "Diaper Change", note: notes)
                    dismiss()
                }.padding()
//                .padding(.leading)
//                .padding(.trailing)
                    .frame(width: 300, height: 50, alignment: .center)
                .background(Color(.white))                .cornerRadius(15)
                .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                .padding(.bottom)
    //            }
    //            Spacer()
            }.background(Color(red: 180/255, green: 200/255, blue: 255/255))
                .cornerRadius(25)
        } .padding(.top, 120)
        
    }
}

struct DiaperView_Previews: PreviewProvider {
    static var previews: some View {
        DiaperView()
    }
}
