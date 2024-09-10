//
//  AddProfilePhotosView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/2/24.
//

import SwiftUI
import PhotosUI

struct AddProfilePhotosView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    private let minNumberOfPhotos = 2
    private let maxNumberOfPhotos = 6
    
    private var columns: [GridItem] {
        return Array(repeating: .init(), count: 3)
    }
    
    @State private var selectedPhotoItems = [PhotosPickerItem]()
    @State private var profileImages = [Image]()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Add your recent pics")
                    .font(.title)
                    .bold()
                
                Text("The first item will be your main profile picture")
                    .font(.footnote)
                    .opacity(0.9)
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: maxNumberOfPhotos) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(0 ... maxNumberOfPhotos - 1, id: \.self) { index in
                        if index < profileImages.count {
                            profileImages[index]
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            ZStack(alignment: .bottomTrailing) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 110, height: 160)
                                
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .foregroundStyle(.white)
                                    .offset(x: 8, y: 4)
                            }
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            HStack {
                ZStack {
                    Circle()
                        .stroke(Color(.systemGray3), lineWidth: 2)
                        .frame(width: 48, height: 48)
                    
                    Text("\(profileImages.count) / \(maxNumberOfPhotos)")
                        .fontWeight(.semibold)
                }
                
                Text("Hey! Let's add 2 to start. We recommend a face pic.")
            }
            .padding(.vertical)
            .font(.subheadline)
            
            NextButton(formIsValid: formIsValid)
        }
        .onChange(of: selectedPhotoItems, perform: { value in
            loadProfilePhotos()
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

extension AddProfilePhotosView: FormValidatorProtocol {
    var formIsValid: Bool {
        return profileImages.count > 1
    }
}

private extension AddProfilePhotosView {
    func loadProfilePhotos() {
        Task {
            var images = [UIImage]()
            
            for item in selectedPhotoItems {
                guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
                guard let uiImage = UIImage(data: imageData) else { return }
                images.append(uiImage)
            }
            
            self.profileImages = images.map({ Image(uiImage: $0) })
            onboardingManager.profilePhotos = images
        }
    }
}

#Preview {
    AddProfilePhotosView()
}
