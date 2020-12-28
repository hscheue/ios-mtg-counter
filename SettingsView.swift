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
                Text("2 Players").tag(2)
                Text("3 Players").tag(3)
                Text("4 Players").tag(4)
                Text("5 Players").tag(5)
                Text("6 Players").tag(6)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Lifetotal", selection: $setting.startingLife) {
                Text("Standard").tag(20)
                Text("Brawl").tag(25)
                Text("Commander").tag(40)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Setting())
    }
}
