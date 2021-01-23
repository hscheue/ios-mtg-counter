//
//  TrailingView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/23/21.
//

import SwiftUI

struct Trailing: View {
    let players: [PlayerState]
    let restartAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: restartAction) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: DieRollView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "die.face.5.fill")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: HistoryView(players: players)
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: SettingsView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 32))
            }
        }
    }
}