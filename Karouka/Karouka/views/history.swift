//
//  history.swift
//  Karouka
//
//  Created by rawan alamirah on 02/11/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct history: View {
    @EnvironmentObject var activityManager: ActivityManager

    var body: some View {
        let sortedActivities = activityManager.groupedActivities.sorted(by: { $0.0 > $1.0 })
        List {
                   ForEach(sortedActivities, id: \.0) { date, activities in
                       Section(header: Text(formatDate(date: date))) {
                           ForEach(activities) { activity in
                               ActivityRow(activity: activity)
                           }
                       }
                   }
               }
               .cornerRadius(15)
               .refreshable { await refreshData() }
    }

    @Sendable func refreshData() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        activityManager.fetchActivity()
    }

    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
}

struct ActivityRow: View {
    let activity: Activity

    var body: some View {
        HStack {
            Image(activity.icon)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.trailing)
            
            Text(activity.date, style: .time)
                .foregroundColor(.white)
            
            Divider()

            Text(activity.name)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.trailing)
        }
        .frame(width: 300, height: 50)
        .background(Color(red: 180/255, green: 200/255, blue: 255/255))
        .cornerRadius(15)
    }
}
       

struct history_Previews: PreviewProvider {
    static var previews: some View {
        history()
    }
}
