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
                    } else {
                        PhotosPicker(selection: $selectedPickerItem) {
                            ZStack(alignment: .bottomTrailing) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 110, height: 160)
                                
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .foregroundStyle(.white)
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
        .onChange(of: selectedPickerItem, perform: { _ in
            uploadProfilePhoto()
        })
    }
}

private extension ProfileImageGridView {
    func uploadProfilePhoto() {
        guard let user = userManager.currentUser else { return }
        
        Task {
            uploadingPhoto = true
            
            guard let selectedPickerItem else { return }
            guard let imageData = try? await selectedPickerItem.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else { return }

            await userManager.uploadUserData(user, profilePhotos: [uiImage])
            
            self.selectedPickerItem = nil
            self.selectedIndex = nil
            self.uploadingPhoto = false
        }
    }
}

#Preview {
    ProfileImageGridView()
        .environmentObject(UserManager(service: MockUserService()))
}
