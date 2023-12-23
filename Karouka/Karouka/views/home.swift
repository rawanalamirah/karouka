//
//  home.swift
//  Karouka
//
//  Created by rawan alamirah on 30/10/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct home: View {
    @State private var rockingMotion = false
    @State private var sound = false
    @State private var diaperSheet = false
    @State private var nurseSheet = false
    @State private var medsSheet = false
    @EnvironmentObject var activityManager : ActivityManager
    @EnvironmentObject var patientModel : PatientDataViewModel
    
    @State private var imagedata: Data?

    var body: some View {
        ZStack {
            Color(red: 265/255, green: 190/255, blue: 230/255)
                .opacity(0.4)
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    ZStack {
                        VStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(25)
                                .frame(width: 360, height: 200)
                                .padding(.top, 30)
                                .shadow(color: .white, radius: 25, x: 5, y: 0)
                                .overlay(
                                    Group {
                                        VStack {
                                            WebView(urlString: "http://172.20.10.8:8000/video")
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                        if let imageData = imagedata, let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                )
                                .onAppear {
                                    fetchCameraImage()
                                }
                            
                        }
                    }
                    .cornerRadius(25)
                    .frame(width: 360, height: 200)
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
                                                .frame(width: 390, height: 180, alignment: .center)

                                            VStack {
                                                HStack (spacing: 50){
                                                    
                                                    VitalSign(title: "Heart Rate", text: patientModel.heartRate, unit: "BPM")
                                                    
                                                    VitalSign(title: "O2 Sat Level", text: patientModel.O2, unit: "%")
                                                    
                                                    VitalSign(title: "Temperature", text: patientModel.newTemp, unit: "ºC")
                                                    
                                                }.padding()
                                                
                                            } .onAppear {
                                                DispatchQueue.main.async {
                                                    patientModel.fetchData()
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                            patientModel.objectWillChange.send()
                                                                        }
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
                                        
                                        VStack {
                                            HStack {
                                                Toggle("Rocking", isOn: $rockingMotion)
                                                    .padding()
                                                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    .background(Color(.white))
                                                    .cornerRadius(15)
                                                    .onChange(of: rockingMotion) { newValue in
                                                        patientModel.updateServo(newValue: newValue)
                                                    }
                                                Toggle("Sound", isOn: $sound)
                                                    .padding()
                                                    .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    .background(Color(.white))
                                                    .cornerRadius(15)
                                                    .onChange(of: sound) { newValue in
                                                        patientModel.updateSong1(newValue: newValue)
                                                    }
                                                
                                            }.padding()
                                            
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    VStack {
                                                        Text("Bed Inclination")
                                                            .font(.system(size: 30))
                                                            .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                        Text("Incline or Decline?")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    Button{
                                                        patientModel.reset(newValue: true)
                                                    } label: {
                                                        Text("RESET")
                                                            .font(.system(size: 7))
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(width: 30, height: 30)
                                                    .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    .clipShape(Circle())                                                }
                                                    
                                                
                                                HStack (spacing: 30){
                                                    
                                                    Button {
                                                        patientModel.incline(newValue: true)
                                                    } label: {
                                                        Image(systemName: "arrow.up")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(.white)

                                                        
                                                    }
                                                    .frame(width: 125, height: 40)
                                                    .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    .cornerRadius(15)
                                                    Spacer()
                                                    
                                                    
                                                    Button {
                                                        patientModel.decline(newValue: true)
                                                    } label: {
                                                        Image(systemName: "arrow.down")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(.white)
      
                                                    }
                                                    .frame(width: 125, height: 40)
                                                    .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                                                    .cornerRadius(15)

                                                }

                                            }
                                            .padding()
                                            .frame(width: 390)
                                            .background(Color(.white))
                                            .cornerRadius(15)
                                                
                                            
                                            
                                        }
                                        
                                        HStack {
                                            Text("Add Activity")
                                                .bold()
                                                .padding(.bottom, -15)
                                                .padding()
                                                .font(.system(size: 25))
                                            Spacer()
                                        }
                                        
                                        HStack (spacing: 60){
                                            
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
                                        .padding(.bottom, 70)
                                        
                                        Spacer()
                    
                }
            }.refreshable { await refreshData() }
        }
    }

    func fetchCameraImage() {
        let cameraURL = URL(string: "http://172.20.10.8:8000/video")!

        URLSession.shared.dataTask(with: cameraURL) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imagedata = data
                }
            } else {
                // Handle error 
                print("Error fetching camera image:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }
}

@Sendable func refreshData() async {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
}






struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
            .environmentObject(PatientDataViewModel())
    }
}
