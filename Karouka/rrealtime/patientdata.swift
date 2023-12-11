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
    
    private var ref: DatabaseReference!
    private var cancellable: AnyCancellable?
    
    init() {
        ref = Database.database().reference().child("patient1") // Replace "patient1" with your node name
        
        // Fetch initial data and observe changes
        fetchData()
        observeDataChanges()
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
    }

    
    func updatePump1(newValue: Bool) {
        let intValue = newValue ? "1" : "0"
        updateValue(for: "pump1", newValue: intValue)
    }
    
    func updatePump2(newValue: Bool) {
        let intValue = newValue ? "2" : "0"
        updateValue(for: "pump1", newValue: intValue)
    }
    
    func updateServo(newValue: Bool) {
        let intValue = newValue ? "1" : "0"
        updateValue(for: "servo", newValue: intValue)
    }
    
    func updateSong1(newValue: Bool) {
        let intValue = newValue ? "2" : "0"
        updateValue(for: "song1", newValue: intValue)
    }
    
    private func updateValue(for key: String, newValue: String) {
        ref.child(key).setValue(newValue)
    }
    
    deinit {
        cancellable?.cancel()
    }
}
