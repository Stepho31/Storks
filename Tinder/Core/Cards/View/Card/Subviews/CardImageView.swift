//
//  CardImageView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI
import Kingfisher
struct CardImageView: View {
    let user: User
    @Binding var currentImageIndex: Int
    
    var body: some View {
        KFImage(URL(string: user.profileImageURLs[currentImageIndex]))
            .resizable()
            .scaledToFill()
            .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
            .overlay {
                ImageScrollingOverlay(imageCount: user.numberOfImages,
                                      currentIndex: $currentImageIndex)
            }
    }
}

#Preview {
    CardImageView(user: DeveloperPreview.user, currentImageIndex: .constant(0))
}
