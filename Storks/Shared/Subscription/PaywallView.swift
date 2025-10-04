//
//  PaywallView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI
import Firebase

struct PaywallView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Storks Plans")
                    .font(.largeTitle).bold()
                    .padding(.top, 12)
                
                PlanCardView(title: "Free", price: "$0", subtitle: "Try risk-free", features: [
                    "Create profile & upload photos",
                    "Answer questionnaire",
                    "Browse matches",
                    "Send limited likes",
                    "Chat after mutual match"
                ], highlight: false)
                
                PlanCardView(title: "Storks Plus", price: "$9.99/mo", subtitle: "Freedom & control", features: [
                    "Unlimited likes & matches",
                    "Advanced filters",
                    "Priority placement",
                    "Read receipts"
                ], highlight: true) {
                    upgrade(to: .plus)
                }
                
                PlanCardView(title: "Storks Premium", price: "$19.99/mo", subtitle: "VIP-level experience", features: [
                    "AI Date Concierge",
                    "5 monthly boosts",
                    "Premium forums & events",
                    "AI conversation starters",
                    "Skip-the-line matching"
                ], highlight: true) {
                    upgrade(to: .premium)
                }
                
                Text("Upgrades billed monthly. Cancel anytime.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 24)
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
    
    private func upgrade(to plan: SubscriptionPlan) {
        guard var current = userManager.currentUser else { return }
        current.plan = plan
        Task {
            do {
                try await EditProfileService().saveUserData(current)
                await userManager.fetchCurrentUser()
                dismiss()
            } catch {
                print("Failed to upgrade plan: \(error)")
            }
        }
    }
}

private struct PlanCardView: View {
    let title: String
    let price: String
    let subtitle: String
    let features: [String]
    let highlight: Bool
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title).font(.title2).bold()
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Text(price).font(.title3).bold()
            }
            ForEach(features, id: \.self) { item in
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                    Text(item)
                }
            }
            Button(action: { action?() }) {
                Text(highlight ? "Upgrade" : "Continue Free")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(highlight ? Color.blue : Color.gray.opacity(0.2), lineWidth: highlight ? 2 : 1)
        )
    }
}

#Preview {
    NavigationStack { PaywallView() }
}
