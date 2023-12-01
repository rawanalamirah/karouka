//
//  patientdata.swift
//  Karouka
//
//  Created by Rawan Alamirah on 27/11/2023.
//

import SwiftUI
import FirebaseDatabase
import Combine

class PatientDataViewModel: ObservableObject {
    @Published var o2: Double = 0.0
    @Published var temp: Double = 0.0
    @Published var heartRate: Double = 0.0
    
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
            if let value = snapshot.value as? [String: Double] {
                self.o2 = value["o2"] ?? 0.0
                self.temp = value["temp"] ?? 0.0
                self.heartRate = value["heartrate"] ?? 0.0
            }
        }
    }
    
    func observeDataChanges() {
            let subject = PassthroughSubject<DataSnapshot, Never>()
            
            cancellable = subject
                .sink { snapshot in
                    if let value = snapshot.value as? [String: Double] {
                        self.o2 = value["o2"] ?? 0.0
                        self.temp = value["temp"] ?? 0.0
                        self.heartRate = value["heartrate"] ?? 0.0
                    }
                }
            
            ref.observe(.value) { snapshot in
                subject.send(snapshot)
            }
        }
    
    
    func updatePump1(newValue: Bool) {
            let intValue = newValue ? 1 : 0
            updateValue(for: "pump1", newValue: intValue)
        }
        
        func updatePump2(newValue: Bool) {
            let intValue = newValue ? 1 : 0
            updateValue(for: "pump2", newValue: intValue)
        }
    
    // Function to update servo value in the Realtime Database
    func updateServo(newValue: Bool) {
            let intValue = newValue ? 1 : 0
            updateValue(for: "servo", newValue: intValue)
        }
    
    // Function to update song1 value in the Realtime Database
    func updateSong1(newValue: Bool) {
            let intValue = newValue ? 1 : 0
            updateValue(for: "song1", newValue: intValue)
        }
    
    private func updateValue(for key: String, newValue: Int) {
           ref.child("patient1/\(key)").setValue(newValue)
       }
    
    deinit {
        cancellable?.cancel()
    }
}
