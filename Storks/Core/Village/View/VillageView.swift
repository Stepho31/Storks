//
//  VillageView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI

struct VillageView: View {
    @State private var selection: VillageSection = .community
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("Mode", selection: $selection) {
                    Text("Community").tag(VillageSection.community)
                    Text("Events").tag(VillageSection.events)
                    Text("Mentorship").tag(VillageSection.mentorship)
                    Text("Concierge").tag(VillageSection.concierge)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Group {
                    switch selection {
                    case .community:
                        VillageCommunityFeed()
                    case .events:
                        VillageEventsView()
                    case .mentorship:
                        VillageMentorshipView()
                    case .concierge:
                        ConciergeEntryView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Village")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private enum VillageSection: Hashable {
    case community
    case events
    case mentorship
    case concierge
}

struct VillageCommunityFeed: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Ask for advice, share wins, and plan meetups.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            List {
                Section("Today") {
                    Text("What are your favorite kid-friendly rainy day activities?")
                    Text("Anyone used a sitter service they trust in Brooklyn?")
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct VillageEventsView: View {
    var body: some View {
        List {
            Section("Upcoming") {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Park Playdate")
                        Text("Sat 10am · Kid-friendly").font(.footnote).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("RSVP") {}
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Parents Night Out")
                        Text("Fri 7pm · Kid-free").font(.footnote).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Details") {}
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct VillageMentorshipView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Find or offer mentorship in parenting, careers, or life balance.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            List {
                Section("Suggestions") {
                    Text("Career coaching · Product Manager (7y)")
                    Text("Newly single parent support · 1:1 chats")
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct ConciergeEntryView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showPaywall = false
    var body: some View {
        VStack(spacing: 16) {
            Text("Premium concierge can plan your date: dinner, childcare, and rides.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if PlanGating.entitlements(for: userManager.currentUser?.plan ?? .free).aiDateConcierge {
                NavigationLink("Plan a Night Out") { ConciergePlannerView() }
            } else {
                Button("Unlock Concierge") { showPaywall = true }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.systemBlue))
                    .controlSize(.large)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(.systemBlue))
            .controlSize(.large)
            
            Spacer()
        }
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }
}

struct ConciergePlannerView: View {
    @State private var isKidFree = true
    @State private var dateWindow: AvailabilityPreset = .weekendEvening
    @State private var location = ""
    
    var body: some View {
        Form {
            Section("Preferences") {
                Toggle("Kid-free night", isOn: $isKidFree)
                Picker("Time", selection: $dateWindow) {
                    ForEach(AvailabilityPreset.allCases) { preset in
                        Text(preset.description).tag(preset)
                    }
                }
                TextField("Neighborhood or city", text: $location)
            }
            
            Section("What we'll handle") {
                Label("Book sitter (if needed)", systemImage: "person.badge.shield.checkmark")
                Label("Reserve dinner", systemImage: "fork.knife")
                Label("Arrange ride", systemImage: "car")
            }
            
            Section {
                Button("Ask AI to plan it") {
                    // Hook up to AI planning service later
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Concierge Planner")
    }
}

#Preview {
    NavigationStack { VillageView() }
}
