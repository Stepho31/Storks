//
//  WelcomeView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/23/24.
//

import SwiftUI

struct WelcomeView: View {    
    @EnvironmentObject var userManager: UserManager
    @StateObject var onboardingManager = OnboardingManager(service: OnboardingService())
    
    var body: some View {
        NavigationStack(path: $onboardingManager.navigationPath) {
            ZStack {
                if onboardingManager.uploadingUserData {
                    ProgressView()
                } else {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(.storksBigLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 96)
                                .padding(.leading, -50)
                            
                            Text("Welcome to Storks!")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Please follow these House Rules.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WelcomeInfoItemView(title: "Be Yourself.", subtitle: "Make sure your photos, age, and bio are true to who you are.")
                        
                        WelcomeInfoItemView(title: "Stay safe.", subtitle: "Don't be too quick to give out personal information.")
                        
                        WelcomeInfoItemView(title: "Play it cool.", subtitle: "Respect others and treat them as you would like to be treated.")
                        
                        WelcomeInfoItemView(title: "Be proactive.", subtitle: "Always report bad behavior.")
                        
                        Spacer()
                        
                        Button {
                            onboardingManager.start()
                        } label: {
                            Text("I agree")
                                .modifier(TinderButtonModifier())
                        }
                    }
                }
            }
            .onChange(of: onboardingManager.user, { oldValue, newValue in
                userManager.currentUser = newValue
            })
            .navigationDestination(for: OnboardingSteps.self, destination: { step in
                VStack {
                    switch step {
                    case .name:
                        FullNameView()
                    case .birthday:
                        BirthdayView()
                    case .occupation:
                        OccupationView()
                    case .gender:
                        GenderView()
                    case .sexualOrientation:
                        SexualOrientationView()
                    case .numberOfChildren:
                        NumberOfChildrenView()
                    case .photos:
                        AddProfilePhotosView()
                    }
                }
                .environmentObject(onboardingManager)
                .navigationBarBackButtonHidden()
            })
            .padding()
        }
    }
}

//#Preview {
//    WelcomeView()
//        .preferredColorScheme(.dark)
//}
