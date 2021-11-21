//
//  TimerObject.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/30/21.
//

import SwiftUI
import Combine
import AVFoundation

class TimerObject: ObservableObject {
    @EnvironmentObject var setting: SettingsState
    private var cancellable = Set<AnyCancellable>()
    private var timerSoundEffect: AVAudioPlayer? = nil
    @AppStorage("timeRemaining") private var timeRemaining: TimeInterval = .zero

    init() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink() { _ in self.decrement() }
            .store(in: &cancellable)

        let path = Bundle.main.path(forResource: "buzzer.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        timerSoundEffect = try? AVAudioPlayer(contentsOf: url)
    }
    
    private func decrement() {
        if self.timeRemaining > .zero {
            self.timeRemaining -= 1
            if self.timeRemaining == .zero {
                self.timerSoundEffect?.play()
            }
        }
    }
    
    public var display: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self.timeRemaining)!
    }
    
    public var accessibilityDisplay: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter.string(from: self.timeRemaining)!
    }
    
    public func increment(_ value: Int) {
        self.timeRemaining += TimeInterval(value)
    }
    
    public func stop() {
        self.timeRemaining = .zero
    }
}
