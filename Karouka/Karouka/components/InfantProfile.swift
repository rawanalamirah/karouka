//
//  InfantProfile.swift
//  Karouka
//
//  Created by Rawan Alamirah on 24/11/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// Define InfantProfile model
struct InfantProfile: Codable {
    var weight: String
    var age: String
    var bloodType: String
    // Add more properties as needed
}

// Define InfantProfileViewModel
class InfantProfileViewModel: ObservableObject {
    @Published var infant: InfantProfile? = InfantProfile(weight: "", age: "", bloodType: "")


    // Function to fetch infant profile from Firestore
//    func fetchInfantProfile() {
//        // Fetch infant profile from Firestore and update the 'infant' property
//        let userId = Auth.auth().currentUser?.uid ?? ""
//        let docRef = Firestore.firestore().collection("infantProfiles").document(userId)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                do {
//                    self.infant = try document.data(as: InfantProfile.self)
//                } catch {
//                    print("Error decoding infant profile: \(error.localizedDescription)")
//                }
//            } else {
//                print("Infant profile document does not exist")
//            }
//        }
//    }

    // Function to update infant's weight in Firestore
    func updateInfantProfile(weight: String, age: String, bloodType: String) {
            // Update the infant's profile locally
            infant?.weight = weight
            infant?.age = age
            infant?.bloodType = bloodType
            

        }

}
