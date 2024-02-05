//
//  InboxLoadingView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import SwiftUI

struct InboxLoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .listRowSeparator(.hidden)
        .frame(height: 300)
    }
}

#Preview {
    InboxLoadingView()
}
