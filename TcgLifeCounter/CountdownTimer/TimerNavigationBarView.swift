//
//  TimerNavigationBarView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/30/21.
//

import SwiftUI

struct TimerNavigationBarView: View {
    @EnvironmentObject var setting: SettingsState
    @StateObject var timer = TimerObject()
    
    var body: some View {
        if setting.enableShotClock {
            HStack {
                Button(action: timer.stop, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                })
                .accessibilityLabel("Clear Shotclock Timer")
                
                Button(action: { timer.increment(setting.shotClockIncrement) }, label: {
                    Text("\(timer.display)")
                        .font(.system(size: 18))
                        .frame(minWidth: 64)
                })
                .accessibilityLabel("Add \(setting.shotClockIncrement) seconds to shot clock")
                .accessibilityValue("\(timer.accessibilityDisplay) remaining")
            }
            .buttonStyle(.plain)
        }
    }
}

struct TimerNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        TimerNavigationBarView()
            .environmentObject(SettingsState())
    }
}
