//
//  Setting.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

class Setting: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case startingLife, playerCount, customValue, playersFaceOutwards, debounceValue
    }
    
    @Published var startingLife: Int { didSet { save() } }
    @Published var playerCount: Int { didSet { save() } }
    @Published var customValue: Int { didSet { save() } }
    @Published var playersFaceOutwards: Bool { didSet { save() } }
    @Published var debounceValue: Double { didSet { save() } }
    
    func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            UserDefaults.standard.set(data, forKey: "SettingKey")
        }
    }
    
    init() {
        // TODO: better in factory initializer?
        if let data = UserDefaults.standard.data(forKey: "SettingKey") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Setting.self, from: data) {
                startingLife = decoded.startingLife
                playerCount = decoded.playerCount
                customValue = decoded.customValue
                playersFaceOutwards = decoded.playersFaceOutwards
                debounceValue = decoded.debounceValue
                return
            }
        }
        startingLife = 20
        playerCount = 2
        customValue = 30
        playersFaceOutwards = false
        debounceValue = 2.0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(startingLife, forKey: .startingLife)
        try container.encode(playerCount, forKey: .playerCount)
        try container.encode(customValue, forKey: .customValue)
        try container.encode(playersFaceOutwards, forKey: .playersFaceOutwards)
        try container.encode(debounceValue, forKey: .debounceValue)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        startingLife = try container.decode(Int.self, forKey: .startingLife)
        playerCount = try container.decode(Int.self, forKey: .playerCount)
        customValue = (try? container.decode(Int.self, forKey: .customValue)) ?? 20
        playersFaceOutwards = (try? container.decode(Bool.self, forKey: .playersFaceOutwards)) ?? false
        debounceValue = (try? container.decode(Double.self, forKey: .debounceValue)) ?? 2.0
    }
}
