//
//  UserProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    @State private var currentImageIndex = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text(user.firstName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("\(user.age)")
                    .font(.title2)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack {
                    ZStack(alignment: .top) {
                        CardImageView(user: user, currentImageIndex: $currentImageIndex)
                        
                        ImageIndicatorView(imageCount: user.numberOfImages, currentIndex: $currentImageIndex)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About me")
                            .fontWeight(.semibold)
                        
                        if let bio = user.bio {
                            Text(bio)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Essentials")
                            .fontWeight(.semibold)

                        
                        ProfileInfoRowView(imageName: "person", title: user.gender.description)
                        ProfileInfoRowView(imageName: "arrow.down.forward.and.arrow.up.backward.circle",
                                           title: user.sexualOrientation.description)
                        ProfileInfoRowView(imageName: "book", title: user.major)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Looking for")
                            .fontWeight(.semibold)
                        
                        Text(RelationshipGoalsType.longTermOpenToShort.fullDescription)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack {
                    Button {
                        
                    } label: {
                        Text("Block \(user.firstName)")
                            .foregroundStyle(.black)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.white)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Report \(user.firstName)")
                            .foregroundStyle(.red)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.white)
                    }
                }
                .padding(.vertical)

            }
            .scrollIndicators(.hidden)
            .background(Color(.systemGroupedBackground))
        }

    }
}

#Preview {
    UserProfileView(user: DeveloperPreview.user)
        .preferredColorScheme(.dark)
}
