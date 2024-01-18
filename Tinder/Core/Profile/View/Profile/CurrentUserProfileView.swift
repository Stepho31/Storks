//
//  ProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showEditProfile = false
    
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
                        
                        Text("Stephan Dowless")
                    }
                    
                    HStack {
                        Text("Email")
                        
                        Spacer()
                        
                        Text("test@gmail.com")
                    }
                }
                
                Section("Legal") {
                    Text("Terms of Service")
                }
                
                Section {
                    Button("Logout") {
                        
                    }
                    .foregroundStyle(.red)
                }
                
                Section {
                    Button("Delete Account") {
                        
                    }
                    .foregroundStyle(.red)
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

#Preview {
    CurrentUserProfileView()
}
