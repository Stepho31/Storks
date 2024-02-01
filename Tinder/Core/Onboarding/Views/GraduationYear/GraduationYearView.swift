//
//  GraduationYearView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct GraduationYearView: View {
    
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var year: String = ""
    var currentYear =  Calendar.current.component(.year, from: Date.now)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your graduation year?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    Menu(year.isEmpty ? "Graduation Year" : "\(year)") {
                        ForEach(currentYear...endYear, id: \.self) { year in
                            let year = year.formatted(.number.grouping(.never))
                            Button(action: {
                                self.year = String(year)
                            }, label: {
                                Text("\(year)")
                            })
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("This is how it'll appear in your profile.")
                            .font(.footnote)
                            .opacity(0.6)
                        
                        Text("You can modify this later.")
                            .font(.footnote)
                            .bold()
                    }
                    .padding(.vertical, 6)
                }
                
                Spacer()
            }
            
            NextButton()
        }
        .backgroundModifier()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

extension GraduationYearView {
    var endYear: Int {
        return currentYear + 4
    }
}

#Preview {
    GraduationYearView()
        .environmentObject(OnboardingManager())
}
