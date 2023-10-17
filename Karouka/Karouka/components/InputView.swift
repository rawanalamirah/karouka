//
//  InputView.swift
//  Karouka
//
//  Created by rawan alamirah on 17/10/2023.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.top)
            Spacer()
        }
        if isSecuredField == true {
            SecureField(placeholder, text: $text)
            Divider()
        } else {
            TextField(placeholder, text: $text)
            Divider()
        }
        
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "email", placeholder: "example@email.com")
    }
}
