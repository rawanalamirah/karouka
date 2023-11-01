//
//  home.swift
//  Karouka
//
//  Created by rawan alamirah on 30/10/2023.
//

import SwiftUI
import Firebase

struct home: View {
    @State private var rockingMotion = false
    @State private var sound = false
    @State private var showingSheet = false
    var body: some View {
        
        ZStack {
            Color(red: 265/255, green: 190/255, blue: 230/255).opacity(0.4)
            
            ScrollView {
                VStack {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(25)
                        .frame(width: 360, height: 200, alignment: .center)
                        .shadow(color: .white, radius: 25, x: 5, y: 0)
                        .padding(.top, 30)
                    HStack {
                        Text("Vital Signs")
                            .bold()
                            .padding(.bottom, -15)
                            .padding()
                            .font(.system(size: 25))
                        Spacer()
                    }
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(25)
                            .frame(width: 350, height: 280, alignment: .center)
//                            .shadow(color: .gray, radius: 25, x: 5, y: 0)
                        VStack {
                            HStack (spacing: 80){
                                VitalSign(title: "Temperature", text: "37ºC")

                                VitalSign(title: "Heart Rate", text: "100 BPM")
                            }.padding()
                            HStack (spacing: 80) {
                                VitalSign(title: "Breathing Rate", text: "100 pm")
                              
                                VitalSign(title: "O Sat Level", text: "97%")
                            }.padding()
                        }
                    }
                    
                    HStack {
                        Text("Crib Control")
                            .bold()
                            .padding(.bottom, -35)
                            .padding()
                            .font(.system(size: 25))
                        Spacer()
                    }
                    
                    HStack {
                        Toggle("Rocking", isOn: $rockingMotion)
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(15)
                        Toggle("Sound", isOn: $sound)
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(15)
                    }.padding()
                    
                    HStack {
                        Text("Add Activity")
                            .bold()
                            .padding(.bottom, -15)
                            .padding()
                            .font(.system(size: 25))
                        Spacer()
                    }
                    
                    HStack (spacing: 45){
        
                        AddActivity(title: "Diaper", icon: Image("diaper"))
                            .onTapGesture(perform: {showingSheet.toggle()})
                            .sheet(isPresented: $showingSheet) {sheetView(icon: Image("diaper"), title: "Diaper Change")}
                        AddActivity(title: "Nursing", icon: Image("milk"))
                            .onTapGesture(perform: {showingSheet.toggle()})
                            .sheet(isPresented: $showingSheet) {sheetView(icon: Image("milk"), title: "Nurse")}
                        AddActivity(title: "Meds", icon: Image("pills"))
                            .onTapGesture(perform: {showingSheet.toggle()})
                            .sheet(isPresented: $showingSheet) {sheetView(icon: Image("pills"), title: "Give Meds")}
                        
                        
                    }.padding()
                        .background(Color(.white))
                        .cornerRadius(15)
                    
                    HStack {
                        Text("Day Activity")
                            .bold()
                            .padding(.bottom, -35)
                            .padding()
                            .font(.system(size: 25))
                        Spacer()
                    }
                    
                    ZStack {
                        Text("")
                    }
                    
                }
            }
            
        }.ignoresSafeArea()
}
    }
    

struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
