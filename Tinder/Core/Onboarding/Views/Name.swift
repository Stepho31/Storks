//
//  Name.swift
//  Tinder
//
//  Created by Brandon on 1/29/24.
//

import SwiftUI

struct Name: View {
    @State var firstName: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            BackButton()
            
            Text("What's your first name?")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading) {
                TextField("Enter First Name", text: $firstName)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("This is how it'll appear in your profile.")
                        .font(.footnote)
                        .opacity(0.6)
                    
                    Text("Can't change it later.")
                        .font(.footnote)
                        .bold()
                }
                .padding(.vertical, 6)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Name()
}
