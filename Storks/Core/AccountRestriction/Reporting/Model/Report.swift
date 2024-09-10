//
//  Report.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import Foundation

struct Report: Codable {
    let reporterUid: String
    let accountOwnerUid: String
    let reportReason: ReportOptionsModel
}
