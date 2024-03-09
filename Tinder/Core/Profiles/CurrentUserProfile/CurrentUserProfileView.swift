//
//  ProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userManager: UserManager
    
    @State private var accountDeletionInProgress = false
    @State private var showEditProfile = false
    
    private var user: User? {
        return userManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            List {
                if let user {
                    CurrentUserProfileHeaderView(showEditProfile: $showEditProfile, user: user)
                }
                
                Section("Account Settings") {
                    HStack {
                        Text("Name")
                        
                        Spacer()
                        
                        Text(user?.fullname ?? "")
                    }
                    
                    HStack {
                        Text("Email")
                        
                        Spacer()
                        
                        Text(user?.email ?? "")
                    }
                }
                
                Section("Legal") {
                    Text("Terms of Service")
                }
                
                Section {
                    Button("Logout") { onLogout() }
                        .foregroundStyle(.red)
                }
                
                Section {
                    HStack {
                        Button("Delete Account") { onAccountDelete() }
                            .foregroundStyle(.red)
                        
                        Spacer()
                        
                        if accountDeletionInProgress {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView()
                    .environmentObject(userManager)
            }
        }
    }
}

private extension CurrentUserProfileView {
    func onLogout() {
        userManager.currentUser = nil
        authManager.signout()
    }
    
    func onAccountDelete() {
        Task {
            accountDeletionInProgress = true
            
            await authManager.deleteAccount()
            userManager.currentUser = nil
            
            accountDeletionInProgress = false
        }
    }
}

#Preview {
    CurrentUserProfileView()
        .environmentObject(AuthManager(service: MockAuthService()))
        .environmentObject(UserManager(service: MockUserService()))
}
