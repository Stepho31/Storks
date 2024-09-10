//
//  ProfileImageGridView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct ProfileImageGridView: View {
    @EnvironmentObject var editProfileManager: EditProfileManager 
    @EnvironmentObject var userManager: UserManager
    
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var uploadingPhoto = false
    @State private var selectedIndex: Int?
    @State private var showDeleteConfirmation = false
    
    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            if let user = userManager.currentUser {
                ForEach(0 ..< 6) { index in
                    if index < user.numberOfImages {
                        ZStack(alignment: .bottomTrailing) {
                            KFImage(URL(string: user.profileImageURLs[index]))
//                            Image(user.profileImageURLs[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            if user.profileImageURLs.count > 2 {
                                ZStack {
                                    Circle()
                                        .stroke(.gray, lineWidth: 1.0)
                                        .background(.black)
                                        .clipShape(Circle())
                                    
                                    Image(systemName: "xmark")
                                        .fontWeight(.bold)
                                        .imageScale(.small)
                                        .foregroundStyle(.gray)
                                }
                                .frame(width: 28, height: 28)
                                .offset(x: 4, y: 4)
                            }
                        }
                        .onTapGesture { onImageTap(imageIndex: index) }
                    } else {
                        PhotosPicker(selection: $selectedPickerItem) {
                            ZStack(alignment: .bottomTrailing) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 110, height: 160)
                                
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .foregroundStyle(Color(.secondaryPink))
                                    .offset(x: 4, y: 4)
                            }
                            .overlay {
                                if let selectedIndex, selectedIndex == index && uploadingPhoto {
                                    ProgressView()
                                }
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            selectedIndex = index
                        }))
                    }
                }
            }
        }
        .confirmationDialog("Delete this photo?",
                            isPresented: $showDeleteConfirmation,
                            titleVisibility: .visible,
                            actions: {
            Button("Delete", role: .destructive) {
                deletePhoto()
            }
        })
        .onChange(of: selectedPickerItem, perform: { _ in
            uploadProfilePhoto()
        })
    }
}

private extension ProfileImageGridView {
    func uploadProfilePhoto() {        
        Task {
            uploadingPhoto = true
            
            guard let selectedPickerItem else { return }
            guard let imageData = try? await selectedPickerItem.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else { return }

            if let imageUrl = await editProfileManager.uploadPhoto(uiImage) {
                userManager.currentUser?.profileImageURLs.append(imageUrl)
                self.uploadingPhoto = false
            }
            
            self.selectedPickerItem = nil
            self.selectedIndex = nil
        }
    }
    
    func deletePhoto() {
        Task {
            guard let selectedIndex else { return }
            guard let imageUrl = userManager.currentUser?.profileImageURLs[selectedIndex] else { return }
            
            userManager.currentUser?.profileImageURLs.remove(at: selectedIndex)
            await editProfileManager.deletePhoto(imageUrl)
            
            uploadingPhoto = false
            self.selectedIndex = nil
        }
    }
    
    func onImageTap(imageIndex: Int) {
        selectedIndex = imageIndex
        showDeleteConfirmation.toggle()
    }
}

#Preview {
    ProfileImageGridView()
        .environmentObject(UserManager(service: MockUserService()))
}
