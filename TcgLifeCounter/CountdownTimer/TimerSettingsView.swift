//
//  TimerSettingsView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/30/21.
//

import SwiftUI

struct TimerSettingsView: View {
    @EnvironmentObject var env: Setting

    var body: some View {
        VStack {
            Toggle("Show shot clock timer", isOn: $env.enableShotClock)
        }
    }
}

struct TimerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSettingsView()
            .environmentObject(Setting())
    }
}
