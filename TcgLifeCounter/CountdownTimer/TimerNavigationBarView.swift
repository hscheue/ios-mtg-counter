//
//  TimerNavigationBarView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/30/21.
//

import SwiftUI

struct TimerNavigationBarView: View {
    @EnvironmentObject var setting: Setting
    @StateObject var timer = TimerObject()
    
    var body: some View {
        if setting.enableShotClock {
            HStack {
                Button(action: timer.stop, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                })
                
                Button(action: timer.increment, label: {
                    Text("\(timer.display)")
                        .font(.system(size: 18))
                        .frame(minWidth: 64)
                })
            }
        }
    }
}

struct TimerNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        TimerNavigationBarView()
    }
}
