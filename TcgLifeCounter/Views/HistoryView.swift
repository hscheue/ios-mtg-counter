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
                    Spacer()
                        .frame(height: 24)
                    Text("\(player.name)")
                    ScrollView(.vertical) {
                        ForEach(player.history) { intWithId in
                            Text("\(intWithId.value)")
                                .font(.system(size: 32))
                        }
                    }
                    Spacer()
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
