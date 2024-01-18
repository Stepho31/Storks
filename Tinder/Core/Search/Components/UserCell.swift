//
//  UserCell.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading) {
                Text(user.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(user.age) years old")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding(.leading)
    }
}

#Preview {
    UserCell(user: DeveloperPreview.user)
}
