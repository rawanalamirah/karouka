//
//  ActivityManager.swift
//  Karouka
//
//  Created by rawan alamirah on 02/11/2023.
//

import SwiftUI
import Firebase

class ActivityManager: ObservableObject {
    @Published var Activities: [Activity] = []
    
    init() {
        fetchActivity()
    }
    
    func fetchActivity() {
        Activities.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Activity")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let date = data["date"] as? Date ?? Date.now
                    let name = data["name"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let icon = data["icon"] as? Image ?? Image("")
                    
                    let Activity = Activity(id: id, date: date, name: name, type: type, icon: icon)
                    self.Activities.append(Activity)
                }
            }
            
        }
    }
    
    func addAct(name: String, icon: Image, type: String, note: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Activity").document(name)
        ref.setData(["name": name, "id" : 10, "date" : Date.now, "type": type, "note": note]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
                                
    }
}
