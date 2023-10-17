//
//  user.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import Foundation

struct user: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension user {
    static var MOCK_USER = user(id: NSUUID().uuidString, fullname: "Rawan Alamirah", email: "rawanalamirah@hotmail.com")
}
