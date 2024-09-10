//
//  EditProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

//import SwiftUI
//
//struct EditProfileView: View {
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var userManager: UserManager
//    
//    @State private var bio = ""
//    @State private var occupation = ""
//    @State private var selectedNumberOfChildren: Int = 0
//    @State private var selectedRelationshipGoal: RelationshipGoalsType?
////    @State private var selectedGoalType: RelationshipGoalsType?
//    @State private var selectedGender: GenderType?
//    @State private var selectedOrientation: SexualOrientationType?
//    @State private var sheetConfig: EditProfileSheetConfiguration?
//    
//    @StateObject var editProfileManager = EditProfileManager(service: EditProfileService())
//    
//    private var user: User? {
//        return userManager.currentUser
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView(showsIndicators: false) {
//                ProfileImageGridView()
//                    .environmentObject(editProfileManager)
//                    .padding()
//                
//                VStack(spacing: 24) {
//                    VStack(alignment: .leading) {
//                        Text("ABOUT ME")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        TextField("Add your bio", text: $bio, axis: .vertical)
//                            .padding()
//                            .frame(height: 64, alignment: .top)
//                            .background(Color(.secondarySystemBackground))
//                            .font(.subheadline)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text("OCCUPATION")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        HStack {
//                            Image(systemName: "book")
//                            Text("Occupation")
//                            
//                            Spacer()
//                            
//                            Text(occupation)
//                                .font(.footnote)
//                        }
//                        .padding()
//                        .background(Color(.secondarySystemBackground))
//                        .font(.subheadline)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text("Number of Children")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        HStack {
//                            Text(user?.numberOfChildren.description ?? "Add Number of Children")
//                                .font(.footnote)
//                            
//                            Spacer()
//                            
//                            Image(systemName: "chevron.right")
//                                .imageScale(.small)
//                            
//                        }
//                        .padding()
//                        .background(Color(.secondarySystemBackground))
//                        .font(.subheadline)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text("GENDER")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        HStack {
//                            Text(selectedGender?.description ?? "Add Gender")
//                            
//                            Spacer()
//                            
//                            Image(systemName: "chevron.right")
//                                .imageScale(.small)
//                        }
//                        .padding()
//                        .background(Color(.secondarySystemBackground))
//                        .font(.subheadline)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text("SEXUAL ORIENTATION")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        HStack {
//                            Text(user?.sexualOrientation.description ?? "Add Orientation")
//                            
//                            Spacer()
//                            
//                            Image(systemName: "chevron.right")
//                                .imageScale(.small)
//                        }
//                        .padding()
//                        .background(Color(.secondarySystemBackground))
//                        .font(.subheadline)
//                        .onTapGesture { sheetConfig = .sexualOrientation }
//                    }
//                    VStack(alignment: .leading) {
//                        Text("Relationship Goals")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.leading)
//                        
//                        HStack {
//                            Text(user?.relationshipGoals?.description ?? "Add Goals")
//                            
//                            Spacer()
//                            
//                            Image(systemName: "chevron.right")
//                                .imageScale(.small)
//                        }
//                        .padding()
//                        .background(Color(.secondarySystemBackground))
//                        .font(.subheadline)
//                        .onTapGesture { sheetConfig = .relationshipGoals }
//                    }
//                }
//            }
//            .onAppear { onViewAppear() }
//            .navigationTitle("Edit Info")
//            .navigationBarTitleDisplayMode(.inline)
//            .sheet(item: $sheetConfig) { config in
//                switch config {
//                case .relationshipGoals:
//                    RelationshipGoalsSelectionView(selectedGoalType: $selectedRelationshipGoal)
//                        .presentationDetents([.height(360)])
//                        .presentationDragIndicator(.visible)
//                case .gender:
//                    GenderSelectionView(selectedGender: $selectedGender)
//                        .presentationDetents([.height(300)])
//                        .presentationDragIndicator(.visible)
//                case .sexualOrientation:
//                    SexualOrientationSelectionView(selectedOrientation: $selectedOrientation)
//                        .presentationDetents([.height(500)])
//                        .presentationDragIndicator(.visible)
//                case .numberOfChildren:
//                    NumberOfChildrenSelectionView(numberOfChildren: $selectedNumberOfChildren)
//                              .presentationDetents([.height(300)])
//                              .presentationDragIndicator(.visible)
//                    
//                
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Done") {
//                        Task { await onDoneTapped() }
//                    }
//                    .fontWeight(.semibold)
//                }
//            }
//        }
//    }
//}
//
//private extension EditProfileView {
//    func onViewAppear() {
//        guard let user else { return }
//        
//        print("onViewAppear: Loading user data")
//        self.bio = user.bio ?? ""
//        self.occupation = user.occupation
//        self.selectedGender = user.gender
//        self.selectedOrientation = user.sexualOrientation
//        self.selectedNumberOfChildren = user.numberOfChildren
//        self.selectedRelationshipGoal = user.relationshipGoals
//        
//        print("Loaded relationship goal from user: \(String(describing: selectedRelationshipGoal))")
//    }
//    
//    func onDoneTapped() async {
//        guard let user else { return }
//        
//        print("onDoneTapped: Updating user data")
//        
//        var newUser = User(
//            id: user.id,
//            fullname: user.fullname,
//            email: user.email,
//            age: user.age,
//            profileImageURLs: user.profileImageURLs,
//            bio: self.bio.isEmpty ? nil : self.bio,
//            occupation: self.occupation,
//            gender: self.selectedGender ?? user.gender,
//            sexualOrientation: self.selectedOrientation ?? user.sexualOrientation,
//            numberOfChildren: user.numberOfChildren,
//            relationshipGoals: user.relationshipGoals,
//            blockedUIDs: user.blockedUIDs,
//            blockedByUIDs: user.blockedByUIDs,
//            didCompleteOnboarding: true
//        )
//        print("New relationship goal to save: \(String(describing: newUser.relationshipGoals))")
//        
//        if newUser != user {
//            newUser.relationshipGoals = selectedRelationshipGoal // Make sure to set this
//            await editProfileManager.saveUserData(newUser)
//            userManager.currentUser = newUser
//        }
//        
//        dismiss()
//    }
//}
//
import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    
    @State private var bio = ""
    @State private var occupation = ""
    @State private var selectedNumberOfChildren: Int = 0
    @State private var selectedRelationshipGoal: RelationshipGoalsType?
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
                    VStack(alignment: .leading) {
                        Text("Relationship Goals")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text(user?.relationshipGoals?.description ?? "Add Goals")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .font(.subheadline)
                        .onTapGesture { sheetConfig = .relationshipGoals }
                    }
                }
            }
            .onAppear { onViewAppear() }
            .navigationTitle("Edit Info")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $sheetConfig) { config in
                switch config {
                case .relationshipGoals:
                    RelationshipGoalsSelectionView(selectedGoalType: $selectedRelationshipGoal)
                        .environmentObject(userManager) // Ensure the environment object is passed
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
    
    private func onViewAppear() {
        guard let user else { return }
        
        print("onViewAppear: Loading user data")
        self.bio = user.bio ?? ""
        self.occupation = user.occupation
        self.selectedGender = user.gender
        self.selectedOrientation = user.sexualOrientation
        self.selectedNumberOfChildren = user.numberOfChildren
        self.selectedRelationshipGoal = user.relationshipGoals
        
        print("Loaded relationship goal from user: \(String(describing: selectedRelationshipGoal))")
    }
    
    private func onDoneTapped() async {
        guard let user else { return }
        
        print("onDoneTapped: Updating user data")
        
        var newUser = User(
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
            relationshipGoals: self.selectedRelationshipGoal ?? user.relationshipGoals,
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
