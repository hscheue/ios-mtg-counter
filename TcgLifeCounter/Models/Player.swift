//
//  Player.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

class Player: ObservableObject, Identifiable {
    let id = UUID().uuidString
    @Published var life: Int
    @Published var name: String
    
    init() {
        life = 20
        name = "Player Name"
    }
    
    init(life: Int) {
        self.life = life
        name = "Player Name"
    }
}

class Players {
    var players = [Player]()
}
