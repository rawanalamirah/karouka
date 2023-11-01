//
//  AddActivity.swift
//  Karouka
//
//  Created by rawan alamirah on 31/10/2023.
//

import SwiftUI

struct AddActivity: View {
    let title: String
    let icon : Image
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 5)
                .padding(.bottom, -10)
            icon
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.white)
                .padding(.leading, 40)
                .padding(.bottom, 8)
            
        }.background(Color(red: 180/255, green: 200/255, blue: 255/255))
            .frame(width: 80, height: 100)
            .cornerRadius(15)
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(title: "", icon: Image("diaper"))
    }
}
