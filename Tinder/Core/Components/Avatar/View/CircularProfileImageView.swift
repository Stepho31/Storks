//
//  CircularProfileImageView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    private var borderColor: Color = .clear
    private var borderWidth: CGFloat = 0.0
    
    init(user: User?, size: ProfileImageSize) {
        self.user = user
        self.size = size
    }
    
    var body: some View {
        if let imageUrl = user?.profileImageURLs.first {
//            KFImage(URL(string: imageUrl))
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(borderColor, lineWidth: borderWidth)
                        .shadow(radius: 4)
                }
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
                .overlay {
                    Circle()
                        .stroke(borderColor, lineWidth: borderWidth)
                        .shadow(radius: 4)
                }
        }
    }
}

extension CircularProfileImageView {
    func addBorder(_ color: Color, borderWidth: CGFloat = 2.0) -> CircularProfileImageView {
        var copy = self
        copy.borderColor = color
        copy.borderWidth = borderWidth
        return copy
    }
}

#Preview {
    CircularProfileImageView(user: nil, size: .medium)
        .addBorder(.blue)
}
