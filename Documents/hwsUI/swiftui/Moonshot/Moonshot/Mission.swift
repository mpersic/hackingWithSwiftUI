//
//  Mission.swift
//  Moonshot
//
//  Created by COBE on 21/04/2021.
//

import Foundation
struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        else {
            return "N/A"
        }
    }
    var formattedCrewMates: String {
        var formattedOutput = ""
        for mate in crew {
            formattedOutput += mate.name.capitalizingFirstLetter() + " " + mate.role + "\n"
        }
        formattedOutput.removeLast()
        return formattedOutput
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
