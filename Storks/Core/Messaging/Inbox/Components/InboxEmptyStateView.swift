//
//  InboxEmptyStateView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/3/24.
//

import SwiftUI

struct InboxEmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2.0)
                    .frame(width: 120, height: 160)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                        .frame(width: 120, height: 160)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.green, lineWidth: 4.0)
                        }
                    
                    Text("LIKE")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(.green)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.green, lineWidth: 4)
                                .frame(width: 64, height: 32)
                        }
                        .rotationEffect(.degrees(-30))
                }
                .rotationEffect(.degrees(10))
                .offset(x: 24, y: -16)
            }
            
            VStack(spacing: 16) {
                Text("Get swiping")
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Text("When you match with other users they'll appear here where you can send them a message")
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .listRowSeparator(.hidden)
        .padding(.top, 64)
    }
}

#Preview {
    InboxEmptyStateView()
        .preferredColorScheme(.dark)
}
