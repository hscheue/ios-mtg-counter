//
//  NewButtonView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 11/20/21.
//

import SwiftUI
import Combine
import AVFoundation
import CoreHaptics

struct NewButtonView<Content>: View where Content : View {
    @ObservedObject var playerState: PlayerState
    let clickAction: () -> Void
    var content: Content

    @State private var engine: CHHapticEngine?

    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func handleClick() {
        AudioServicesPlaySystemSound(SystemSoundID(1156))
        complexSuccess()
        clickAction()
        opacity = 0.2
        withAnimation {
            opacity = 0
        }
    }
    
    var body: some View {
        Button(action: handleClick) { content }
        .onAppear(perform: prepareHaptics)
        .contentShape(HalfRoundedRect(.left))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Minus: \(playerState.name)")
        .accessibilityValue("now \(playerState.current?.value ?? 0)")
    }
}


