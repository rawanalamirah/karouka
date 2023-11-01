//
//  history.swift
//  Karouka
//
//  Created by rawan alamirah on 02/11/2023.
//

import SwiftUI

struct history: View {
    @EnvironmentObject var activityManager: ActivityManager
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 180/255, green: 200/255, blue: 255/255)
                
            List(activityManager.Activities, id: \.id) { activity in
                VStack {
                Text("\(activity.date)")
                    .foregroundColor(.white)
                HStack {
                activity.icon
                    .resizable()
                    .frame(width: 50, height: 60, alignment: .center)
                    Divider()
                Text(activity.name)
                        .foregroundColor(.white)
                }
                .padding()
                
                }.background(Color(red: 180/255, green: 200/255, blue: 255/255))
                
            }.background(.white)
                .cornerRadius(15)
            }
        }
    }
}

struct history_Previews: PreviewProvider {
    static var previews: some View {
        history()
    }
}
