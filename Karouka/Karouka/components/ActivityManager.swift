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
    @Published var groupedActivities: [(Date, [Activity])] = []

    
    init() {
        fetchActivity()
    }
    
    func fetchActivity() {
        Activities.removeAll()
        let ref = Firestore.firestore().collection("Activity")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? Int.random(in: 1...10000)
                    let date = (data["date"] as? Timestamp)? .dateValue() ?? Date()
                    let name = data["name"] as? String ?? "rawan"
                    let type = data["type"] as? String ?? "diaper change"
                    let icon = data["icon"] as? String ?? "diaper"
                    
                    let Activity = Activity(id: id, date: date, name: name, type: type, icon: icon)
                    self.Activities.append(Activity)
                }
                self.groupedActivities = groupActivitiesByDate(activities: self.Activities)
            }
            
        }
    }
    
    func addAct(id: Int, name: String, icon: String, type: String, note: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Activity").document(name)
        ref.setData(["id": Int.random(in: 1...10000), "name": name, "type": type, "note": note, "date": Timestamp(), "icon": icon]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
                                
    }
}

func groupActivitiesByDate(activities: [Activity]) -> [(Date, [Activity])] {
      var groupedActivities: [(Date, [Activity])] = []

      for activity in activities {
          let calendar = Calendar.current
          let dateComponents = calendar.dateComponents([.year, .month, .day], from: activity.date)
          let truncatedDate = calendar.date(from: dateComponents)!

          if let index = groupedActivities.firstIndex(where: { $0.0 == truncatedDate }) {
              groupedActivities[index].1.append(activity)
          } else {
              groupedActivities.append((truncatedDate, [activity]))
          }
      }

      return groupedActivities
  }

