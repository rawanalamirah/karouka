//
//  Activity.swift
//  Karouka
//
//  Created by rawan alamirah on 02/11/2023.
//

import SwiftUI

class Activity: Identifiable {
    var id: Int
    var date: Date
    var name: String
    var type: String
    var icon: String
    
    init(id: Int, date: Date, name: String, type: String, icon: String ) {
        self.id = id
        self.date = date
        self.name = name
        self.type = type
        self.icon = icon
    }
}


