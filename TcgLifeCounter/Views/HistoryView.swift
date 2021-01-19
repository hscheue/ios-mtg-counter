//
//  HistoryView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/18/21.
//

import SwiftUI

struct HistoryView: View {
    let players: [PlayerState]

    var body: some View {
        HStack {
            ForEach(players) { player in
                VStack {
                    Text("Player")
                    ForEach(player.history) { intWithId in
                        Text("\(intWithId.value)")
                            .font(.system(size: 32))
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HistoryView(players: [
                PlayerState()
            ])
            Button(action: {}) {
                Text("HI")
            }
        }
        
    }
}
