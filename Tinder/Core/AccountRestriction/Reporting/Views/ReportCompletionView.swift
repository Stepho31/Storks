//
//  ReportCompletionView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import SwiftUI

struct ReportCompletionView: View {
//    @StateObject var viewModel = ReportContentViewModel(service: ReportContentService())
    let dismiss: DismissAction
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .fontWeight(.light)
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.green)
                
                Text("Thanks for letting us know")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("We use these reports to:")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 24)
            
            VStack(alignment: .leading, spacing: 24) {
                AccountRestrictionInfoItemView(imageName: "info.circle", description: "Understand problems people are having with different types of content on Aurora.")
                AccountRestrictionInfoItemView(imageName: "eye.slash", description: "Show you less of this content in the future.")
            }
            .padding()
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                Text("Next")
                    .modifier(TinderButtonModifier())
            }

        }
        .task { }
        .presentationDetents([.height(480)])
    }
}
