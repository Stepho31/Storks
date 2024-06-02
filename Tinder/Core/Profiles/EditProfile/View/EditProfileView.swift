//
//  EditProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    
    @State private var bio = ""
    @State private var occupation = ""
    @State private var selectedNumberOfChildren: Int = 0
    @State private var selectedGoalType: RelationshipGoalsType?
    @State private var selectedGender: GenderType?
    @State private var selectedOrientation: SexualOrientationType?
    @State private var sheetConfig: EditProfileSheetConfiguration?
    
    @StateObject var editProfileManager = EditProfileManager(service: EditProfileService())
    
    private var user: User? {
        return userManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ProfileImageGridView()
                    .environmentObject(editProfileManager)
                    .padding()
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("ABOUT ME")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        TextField("Add your bio", text: $bio, axis: .vertical)
                            .padding()
                            .frame(height: 64, alignment: .top)
                            .background(Color(.secondarySystemBackground))
                            .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("OCCUPATION")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Image(systemName: "book")
                            Text("Occupation")
                            
                            Spacer()
                            
                            Text(occupation)
                                .font(.footnote)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Number of Children")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text(user?.numberOfChildren.description ?? "Add Number of Children")
                                .font(.footnote)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                            
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("GENDER")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text(selectedGender?.description ?? "Add Gender")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("SEXUAL ORIENTATION")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text(user?.sexualOrientation.description ?? "Add Orientation")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                        .onTapGesture { sheetConfig = .sexualOrientation }
                    }
                }
            }
            .onAppear { onViewAppear() }
            .navigationTitle("Edit Info")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $sheetConfig) { config in
                switch config {
                case .relationshipGoals:
                    RelationshipGoalsSelectionView(selectedGoalType: $selectedGoalType)
                        .presentationDetents([.height(360)])
                        .presentationDragIndicator(.visible)
                case .gender:
                    GenderSelectionView(selectedGender: $selectedGender)
                        .presentationDetents([.height(300)])
                        .presentationDragIndicator(.visible)
                case .sexualOrientation:
                    SexualOrientationSelectionView(selectedOrientation: $selectedOrientation)
                        .presentationDetents([.height(500)])
                        .presentationDragIndicator(.visible)
                case .numberOfChildren:
                    NumberOfChildrenSelectionView(numberOfChildren: $selectedNumberOfChildren)
                              .presentationDetents([.height(300)])
                              .presentationDragIndicator(.visible)
                
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        Task { await onDoneTapped() }
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

private extension EditProfileView {
    func onViewAppear() {
        guard let user else { return }
        
        self.bio = user.bio ?? ""
        self.occupation = user.occupation
        self.selectedGender = user.gender
        self.selectedOrientation = user.sexualOrientation
        self.selectedNumberOfChildren = user.numberOfChildren
    }
    
    func onDoneTapped() async {
        guard let user else { return }
        
        let newUser = User(
            id: user.id,
            fullname: user.fullname,
            email: user.email,
            age: user.age,
            profileImageURLs: user.profileImageURLs,
            bio: self.bio.isEmpty ? nil : self.bio,
            occupation: self.occupation,
            gender: self.selectedGender ?? user.gender,
            sexualOrientation: self.selectedOrientation ?? user.sexualOrientation,
            numberOfChildren: user.numberOfChildren,
            blockedUIDs: user.blockedUIDs,
            blockedByUIDs: user.blockedByUIDs,
            didCompleteOnboarding: true
        )
        
        if newUser != user {
            await editProfileManager.saveUserData(newUser)
            userManager.currentUser = newUser
        }
        
        dismiss()
    }
}

//#Preview {
//    NavigationStack {
//        EditProfileView()
//            .environmentObject(UserManager(service: MockUserService()))
//    }
//}
