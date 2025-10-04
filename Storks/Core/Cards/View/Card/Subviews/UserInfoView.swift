//
//  UserInfoView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import SwiftUI

struct UserInfoView: View {
    let user: User
    var compatibilityScore: Int? = nil
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

                if let score = compatibilityScore {
                    Spacer(minLength: 8)
                    Text("\(score)%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .accessibilityLabel("Compatibility score \(score) percent")
                }
                
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
            
            HStack(spacing: 8) {
                if let parenting = user.parentingStyle {
                    Label(parenting.description, systemImage: "figure.2.and.child.holdinghands")
                }
                if let values = user.familyValues, !values.isEmpty {
                    Text(values.prefix(2).map { $0.description }.joined(separator: " · "))
                }
            }
            .font(.subheadline)
            .lineLimit(1)
            
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
