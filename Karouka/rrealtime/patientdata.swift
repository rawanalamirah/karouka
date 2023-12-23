//
//  patientdata.swift
//  Karouka
//
//  Created by Rawan Alamirah on 27/11/2023.
//

import SwiftUI
import FirebaseDatabase
import Firebase
import Combine

class PatientDataViewModel: ObservableObject {
    @Published var O2: String = "0"
    @Published var temp: String = "0"
    @Published var heartRate: String = "0"
    @Published var newTemp: String = "0"
    
    private var ref: DatabaseReference!
    private var cancellable: AnyCancellable?
    
    init() {
        ref = Database.database().reference().child("patient1") // Replace "patient1" with your node name
        
        fetchData()
        observeDataChanges()
        splitTemp()        
    }
    
    func fetchData() {
        ref.observeSingleEvent(of: .value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                print("Fetched data:", value)
                self.O2 = value["O2"] as? String ?? "0"
                self.temp = value["temp"] as? String ?? "0.0"
                self.heartRate = value["heartrate"] as? String ?? "0"
            } else {
                print("Failed to fetch data")
            }
        }
    }

    func observeDataChanges() {
        ref.observe(.value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                print("Data changes observed:", value)
                self.O2 = value["O2"] as? String ?? "0"
                self.temp = value["temp"] as? String ?? "0.0"
                self.heartRate = value["heartrate"] as? String ?? "0"
            } else {
                print("Failed to observe data changes")
            }
        }
        let O2 = Int(self.O2)
        let heart = Int(self.heartRate)
        let facial = Int(self.newTemp)
        
        print(O2 ?? 0)
        print(heart ?? 0)
        print(facial ?? 0)
        
        if (O2 ?? 0 <= 80 && heart ?? 0 >= 160 && facial ?? 0 <= 20) {
            incline(newValue: true)

        }
    }

    
    func incline(newValue: Bool) {
        let intValue = newValue ? "1" : "0"
        updateValue(for: "pump1", newValue: intValue)
        updateValue(for: "pump2", newValue: intValue)

    }
    
    func decline(newValue: Bool) {
        let intValue = newValue ? "2" : "0"
        updateValue(for: "pump1", newValue: intValue)
        updateValue(for: "pump2", newValue: intValue)

    }
    
    func reset(newValue: Bool) {
        let intValue = newValue ? "0" : "0"
        updateValue(for: "pump1", newValue: intValue)
        updateValue(for: "pump2", newValue: intValue)

    }
    
    func updateServo(newValue: Bool) {
        let intValue = newValue ? "1" : "0"
        updateValue(for: "servo", newValue: intValue)
    }
    
    func updateSong1(newValue: Bool) {
        let intValue = newValue ? "2" : "0"
        updateValue(for: "song1", newValue: intValue)
    }
    
    
    func splitTemp() {
        ref.observe(.value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                self.temp = value["temp"] as? String ?? "0.0"
                print(self.temp)
                let parts = self.temp.components(separatedBy: ".")
                let newtemp = parts[0]
                self.newTemp = newtemp
            }
        }
        
    }
    
    private func updateValue(for key: String, newValue: String) {
        ref.child(key).setValue(newValue)
    }
    
    deinit {
        cancellable?.cancel()
    }
}
