//
//  ReportUserView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import Foundation

import SwiftUI

struct ReportUserView: View {
    @Environment(\.dismiss) var dismiss
    
    let user: User
        
    var body: some View {
        NavigationStack {
            VStack {
                Text("Report")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("What would you like to report?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical)
                
                Divider()
                
                List {
                    ForEach(ReportOptionsModel.allCases) { option in
                        HStack {
                            NavigationLink(value: option) {
                                Text(option.title)
                                    .font(.subheadline)
                                    .padding(.vertical, 12)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            
            .navigationDestination(for: ReportOptionsModel.self) { option in
                ReportCompletionView(dismiss: dismiss)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    ReportUserView(user: DeveloperPreview.user)
        .preferredColorScheme(.dark)
}
