//
//  Activity.swift
//  HabbitTracker
//
//  Created by COBE on 26/04/2021.
//

import Foundation
struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var count = 0
}
