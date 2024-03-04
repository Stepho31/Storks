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
    
    @State private var showEditProfile = false
    @State private var accountDeletionInProgress = false
    
    private var user: User? {
        return userManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    ZStack(alignment: .topTrailing) {
                        CircularProfileImageView(user: user, size: .xxLarge)
                            .background {
                                Circle()
                                    .fill(Color(.systemGray6))
                                    .frame(width: 128, height: 128)
                                    .shadow(radius: 10)
                            }
                        
                        Image(systemName: "pencil")
                            .imageScale(.small)
                            .foregroundStyle(.gray)
                            .background {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 32, height: 32)
                            }
                            .offset(x: -8, y: 10.0)
                    }
                    .onTapGesture { showEditProfile.toggle() }
                    
                    if let user {
                        Text("\(user.firstName), \(user.age)")
                            .font(.title2)
                            .fontWeight(.light)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 240)
                .background(.white.opacity(0.01))
                
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
