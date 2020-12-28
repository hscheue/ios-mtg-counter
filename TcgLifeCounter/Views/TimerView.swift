//
//  TimerView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI
import AVKit

struct TimerView: View {
    let speechSynthesizer = AVSpeechSynthesizer()
    let saying = ["Bush did 7/11"].randomElement()
    @State var hasSpoken = false
    @State var timeRemaining: Int
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var minutes: (Int, Int) {
        timeRemaining.quotientAndRemainder(dividingBy: 60)
    }
    
    var body: some View {
        Text("\(minutes.0):\(String(format: "%02d", minutes.1))")
            .font(.system(size: 64))
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else if (hasSpoken == false){
                    self.hasSpoken = true
                    let speechUtterance = AVSpeechUtterance(string: "Bush did 9/11")
                    speechUtterance.voice = AVSpeechSynthesisVoice
                        .speechVoices()
                        .randomElement()
                    speechSynthesizer.speak(speechUtterance)
                }
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: 5)
    }
}
