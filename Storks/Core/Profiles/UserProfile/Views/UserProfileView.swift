//
//  UserProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct UserProfileView: View, UserBlockable {
    @Environment(\.dismiss) var dismiss
    @State private var currentImageIndex = 0
    @State private var sheetConfig: UserProfileSheetConfiguration?
    @State private var accountRestrictionAction: UserAccountRestrictionAction?
    var onBlock: (() -> Void)?
    
    let user: User

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
                        
                        CardImageIndicatorView(imageCount: user.numberOfImages, currentIndex: $currentImageIndex)
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
                        
                        Divider()
                        
                        ProfileInfoRowView(imageName: "arrow.down.forward.and.arrow.up.backward.circle",
                                           title: user.sexualOrientation.description)
                        Divider()

                        ProfileInfoRowView(imageName: "book", title: user.occupation)
                        
                        Divider()
                        
                        ProfileInfoRowView(imageName: "figure.and.child.holdinghands",
                                           title: user.numberOfChildren.description)

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
                        sheetConfig = .block
                    } label: {
                        Text("Block \(user.firstName)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Button {
                        sheetConfig = .report
                    } label: {
                        Text("Report \(user.firstName)")
                            .foregroundStyle(.red)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.vertical)
            }
        }
        .onChange(of: accountRestrictionAction, { oldValue, newValue in
            switch newValue {
            case .blocked:
                if let onBlock { onBlock() }
            case .reported:
                dismiss()
            case .none:
                break
            }
        })
        .sheet(item: $sheetConfig, content: { config in
            switch config {
            case .block:
                BlockUserView(accountRestrictionAction: $accountRestrictionAction, user: user)
            case .report:
                ReportUserView(user: user)
            }
        })
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    UserProfileView(user: DeveloperPreview.user )
//        .preferredColorScheme(.dark)
//}
