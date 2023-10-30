//
//  VitalSign.swift
//  Karouka
//
//  Created by rawan alamirah on 30/10/2023.
//

import SwiftUI

struct VitalSign: View {
    let title : String
    let text : String
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .padding(.bottom, -5)
            Text(text)
                .frame( width: 80, height: 80, alignment: .center)
                .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                .foregroundColor(.white)
                .font(.system(size: 25))
                .clipShape(Circle())

        }    }
}

struct VitalSign_Previews: PreviewProvider {
    static var previews: some View {
        VitalSign(title: "", text: "")
    }
}
