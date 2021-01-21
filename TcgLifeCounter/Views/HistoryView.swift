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
        VStack {
            HStack(alignment: .top) {
                ForEach(players) { player in
                    Text(player.name)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            
            ScrollView(.vertical) {
                ZStack(alignment: .top) {
                    HStack(alignment: .top) {
                        ForEach(players) { player in
                            VStack {
                                ForEach(player.history) { intWithId in
                                    if player.history.last?.id != intWithId.id {
                                        Text("\(intWithId.value)")
                                            .font(.system(size: 32))
                                            .foregroundColor(Color.gray)
                                            .frame(maxWidth: .infinity)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                    } else {
                                        Text("\(intWithId.value)")
                                            .font(.system(size: 40))
                                            .offset(x: 0, y: 0)
                                            .frame(maxWidth: .infinity)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
            }
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(players: [
            PlayerState(0, life: 100, history: [99,88,77,66,55,44,33,22,11,9,8,7,6,5,4,4,3,2,1]),
            PlayerState(1, life: 100, history: [99,88,77,66,55,44,33,22,11]),
            PlayerState(2, life: 100, history: [99,88,77]),
            PlayerState(3, life: 100),
            PlayerState(4, life: 100),
            PlayerState(5, life: 100),
        ])
        
        HistoryView(players: [
            PlayerState(0, life: 100, history: [99,88,77,66,55,44,33,22,11,9,8,7,6,5,4,4,3,2,1]),
            PlayerState(1, life: 100, history: [99,88,77,66,55,44,33,22,11]),
            PlayerState(2, life: 100, history: [99,88,77]),
            PlayerState(3, life: 100),
        ])
        .preferredColorScheme(.dark)
    }
}
