//
//  TimerSettingsView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/30/21.
//

import SwiftUI

struct TimerSettingsView: View {
    @EnvironmentObject var env: Setting
    
    var boolBinding: Binding<Bool> {
        return Binding(get: {
            env.enableShotClock
        }, set: { value in
            withAnimation {
                env.enableShotClock = value
            }
        })
    }

    var binding: Binding<String> {
        return Binding(get: {
            String(env.shotClockIncrement)
        }, set: { value in
            env.shotClockIncrement = Int(value) ?? 0
        })
    }

    var body: some View {
        Toggle("Show shot clock timer", isOn: boolBinding)
        if env.enableShotClock {
            HStack(alignment: .firstTextBaseline) {
                Text("Timer Increment")
                Text("seconds")
                    .foregroundColor(.secondary)
                    .font(.caption)
                TextField("Time", text: binding)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }
            .animation(.default)
        }
    }
}

struct TimerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TimerSettingsView()
        }
        .environmentObject(Setting())
    }
}
