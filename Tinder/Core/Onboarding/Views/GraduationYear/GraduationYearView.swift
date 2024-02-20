//
//  GraduationYearView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct GraduationYearView: View {
    
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var yearAsString: String = ""
    var currentYear =  Calendar.current.component(.year, from: Date.now)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your graduation year?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    Menu(yearAsString.isEmpty ? "Select Graduation Year" : "\(yearAsString)") {
                        ForEach(currentYear...endYear, id: \.self) { year in
                            Button(action: {
                                self.yearAsString = String(year)
                                onboardingManager.graduationYear = year
                            }, label: {
                                Text(String(year))
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
            
            NextButton(formIsValid: formIsValid)
        }
        .backgroundModifier()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

extension GraduationYearView: FormValidatorProtocol {
    var formIsValid: Bool {
        return !yearAsString.isEmpty
    }
}

extension GraduationYearView {
    var endYear: Int {
        return currentYear + 4
    }
}

#Preview {
    GraduationYearView()
        .environmentObject(OnboardingManager(service: .init(imageUploader: .init())))
}
