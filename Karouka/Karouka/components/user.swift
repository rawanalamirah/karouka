//
//  user.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import Foundation
import SwiftUI

struct user: Identifiable, Codable {
    let id: String
    let profilepic: String
    let fullname: String
    let infant: String
    let cribID: String
    let email: String
    let password: String
    
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
    static var MOCK_USER = user(id: NSUUID().uuidString, profilepic: "", fullname: "Rawan Alamirah", infant: "Thuraya", cribID: "", email: "rawanalamirah@hotmail.com", password: "123456")
}
