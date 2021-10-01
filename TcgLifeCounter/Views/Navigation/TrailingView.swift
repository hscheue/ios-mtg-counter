//
//  TrailingView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/23/21.
//
// ios 15 font sizes changed and icons turning blue
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-disable-the-overlay-color-for-images-inside-button-and-navigationlink
//

import SwiftUI

struct Trailing: View {
    let players: [PlayerState]
    let restartAction: () -> Void

    var body: some View {
        HStack {            
            Button(action: restartAction) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 26))
            }
            .accessibilityLabel("Start New Game")
            
            NavigationLink(
                destination: DieRollView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "die.face.5.fill")
                    .font(.system(size: 26))
            }
            .accessibilityLabel("View dice roll options")
            
            NavigationLink(
                destination: HistoryView(players: players)
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 26))
            }
            .accessibilityLabel("View life total history")
            
            NavigationLink(
                destination: SettingsView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 26))
            }
            .accessibilityLabel("View app settings")
        }
        .buttonStyle(.plain)
    }
}
