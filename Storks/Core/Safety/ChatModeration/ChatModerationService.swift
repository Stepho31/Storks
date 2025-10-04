//
//  ChatModerationService.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import Foundation

enum ModerationAction {
    case allow
    case warn(String)
    case block(String)
}

struct ChatModerationService {
    func evaluate(message: String) -> ModerationAction {
        let lowered = message.lowercased()
        // Simple local heuristics; replace with AI moderation endpoint later
        let banned = ["threat", "violence", "harass"]
        if banned.contains(where: { lowered.contains($0) }) {
            return .block("This message violates our safety policy.")
        }
        let risky = ["address", "phone", "meet now", "come over"]
        if risky.contains(where: { lowered.contains($0) }) {
            return .warn("Be cautious sharing personal info or rushing to meet.")
        }
        return .allow
    }
}
