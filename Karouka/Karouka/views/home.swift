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
    @State private var diaperSheet = false
    @State private var nurseSheet = false
    @State private var medsSheet = false
    @State private var imageData: Data?
    @EnvironmentObject var activityManager : ActivityManager
    let today = Date()
    
    var body: some View {
        
        ZStack {
            Color(red: 265/255, green: 190/255, blue: 230/255).opacity(0.4)
            
            ScrollView {
                VStack {
                    ZStack {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(25)
                        .frame(width: 360, height: 200, alignment: .center)
                        .shadow(color: .white, radius: 25, x: 5, y: 0)
                        .padding(.top, 30)
                        VStack {
                                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                    } else {
                                        Text("Loading...")
                                    }
                                }
                                .onAppear {
                                    let cameraURL = URL(string: "http://172.20.10.8:8000/video")!

                                    // Use URLSession to download the image data
                                    URLSession.shared.dataTask(with: cameraURL) { data, response, error in
                                        if let data = data {
                                            DispatchQueue.main.async {
                                                // Update the UI with the downloaded image data
                                                imageData = data
                                            }
                                        }
                                    }.resume()
                                }
                    }
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
                        
                        VStack {
                        AddActivity(title: "Diaper", icon: Image("diaper"))
                            .onTapGesture(perform: {diaperSheet.toggle()})
                            .sheet(isPresented: $diaperSheet, content: {DiaperView()})
                        }
                        
                        
                        VStack {
                        AddActivity(title: "Nursing", icon: Image("milk"))
                            .onTapGesture(perform: {nurseSheet.toggle()})
                            .sheet(isPresented: $nurseSheet, content: {NurseView()})
                        }
                        
                        
                        VStack {
                        AddActivity(title: "Meds", icon: Image("pills"))
                            .onTapGesture(perform: {medsSheet.toggle()})
                            .sheet(isPresented: $medsSheet, content: {MedsView()})
                        }
                        
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(15)
                    .padding(.bottom, 80)
                    
                    Spacer()
                    
//                    HStack {
//                        Text("Day Activity")
//                            .bold()
//                            .padding(.bottom, -15)
//                            .padding()
//                            .font(.system(size: 25))
//                        Spacer()
//                    }
//
//                    VStack {
//                        HStack {
//                            Text(Date.now, style: .date)
//                                .padding(.leading)
//                            Spacer()
//                        }
//
//                         List {
//                             ForEach(activityManager.Activities.filter { isToday($0.date) }) { activity in
//                                 HStack {
//                                 Image(activity.icon)
//                                     .resizable()
//                                     .frame(width: 30, height: 30, alignment: .center)
//                                     .padding(.trailing)
//
//                                 Text(activity.date, style: .time)
//                                     .foregroundColor(.white)
//                                 Divider()
//                                 Text(activity.name)
//                                         .foregroundColor(.white)
//                                         .padding(.leading)
//                                         .padding(.trailing)
//                                 }
//                                 .frame(width: 300, height: 40)
//                                 .background(Color(red: 180/255, green: 200/255, blue: 255/255))
//                                     .cornerRadius(15)
//
//                             }
//                               }
//                            .cornerRadius(15)
//
//                    }
//                        .background(Color(.white))
//                        .cornerRadius(15)
//                        .padding()
                        
                    
                }
            }
            
        }.ignoresSafeArea()
}
    }

func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        return calendar.isDate(date, inSameDayAs: today)
    }
    

struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
