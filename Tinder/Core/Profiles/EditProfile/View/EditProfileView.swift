//
//  EditProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var userManager: UserManager
    
    @State private var bio = ""
    @State private var major = ""
    @State private var graduationYear = ""
    @State private var selectedGoalType: RelationshipGoalsType?
    @State private var selectedGender: GenderType?
    @State private var selectedOrientation: SexualOrientationType?
    @State private var sheetConfig: EditProfileSheetConfiguration?
    
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return userManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ProfileImageGridView()
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
                        Text("COURSE")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Image(systemName: "book")
                            Text("Studying")
                            
                            Spacer()
                            
                            Text(major)
                                .font(.footnote)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("GRADUATION YEAR")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Image(systemName: "book")
                            Text("Graduating")
                            
                            Spacer()
                            
                            Text(graduationYear)
                                .font(.footnote)
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
                        .onTapGesture { sheetConfig = .gender }
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
                }
            }
            .navigationTitle("Edit Info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        onDoneTapped()
                        dismiss()
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
        self.graduationYear = String(user.graduationYear)
        self.major = user.major
        self.selectedGender = user.gender
        self.selectedOrientation = user.sexualOrientation
    }
    
    func onDoneTapped() {
        guard let user else { return }
        
        let newUser = User(
            id: user.id,
            fullname: user.fullname,
            email: user.email,
            age: user.age,
            profileImageURLs: user.profileImageURLs,
            major: self.major,
            graduationYear: user.graduationYear,
            gender: self.selectedGender ?? user.gender,
            sexualOrientation: self.selectedOrientation ?? user.sexualOrientation,
            sexualPreference: user.sexualPreference,
            blockedUIDs: user.blockedUIDs,
            blockedByUIDs: user.blockedByUIDs
        )
        
        if newUser != user {
            print("DEBUG: Update user")
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environmentObject(UserManager(service: MockUserService()))
    }
}
