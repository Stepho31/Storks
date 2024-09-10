//
//  UserInfoView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import SwiftUI

struct UserInfoView: View {
    let user: User
    @Binding var showProfileView: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.firstName)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("\(user.age)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    showProfileView.toggle()
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                        .shadow(radius: 10)
                }
            }
            
            Text(user.bio ?? "")
                .font(.subheadline)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    UserInfoView(user: DeveloperPreview.user, showProfileView: .constant(false))
}
