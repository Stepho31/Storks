//
//  ImageScrollingOverlay.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct ImageScrollingOverlay: View {
    let imageCount: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack {
            Rectangle()
                .onTapGesture { updateImageIndex(increment: false) }
            
            Rectangle()
                .onTapGesture { updateImageIndex(increment: true) }
        }
        .foregroundStyle(.white.opacity(0.01))
    }
    
    private func updateImageIndex(increment: Bool) {
        if increment {
            guard currentIndex < imageCount - 1 else { return }
            currentIndex += 1
        } else {
            guard currentIndex > 0 else { return }
            currentIndex -= 1
        }
    }
}
