//
//  SettingsView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/24/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var setting: Setting
    
    var body: some View {
        List {
            Picker("Players", selection: $setting.playerCount) {
                ForEach(2...6, id: \.self) {
                    Text("\($0) Players").tag($0)
                }
            }
            Picker("Lifetotal", selection: $setting.startingLife) {
                Text("Standard").tag(20)
                Text("Brawl").tag(25)
                Text("Commander").tag(40)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Setting())
    }
}
