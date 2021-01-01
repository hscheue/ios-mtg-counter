//
//  TcgLifeCounterApp.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

enum StoredColorScheme: Int {
    case system, light, dark
}

class SharedSettings {
    static let storageKey = "key"
    
    @Environment(\.colorScheme) static var systemColorScheme
    
    @AppStorage(storageKey) var storedColorScheme: StoredColorScheme = .system
    
    static var shared: SharedSettings { .init() }
    
    static func colorScheme(storedColorScheme: StoredColorScheme) -> ColorScheme {
        switch storedColorScheme {
        case .system:
            return Self.systemColorScheme
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct MyView: View {
    // TODO: Could this just be state here? Could this be observedObject?
    @AppStorage(SharedSettings.storageKey) var storedColorScheme = SharedSettings.shared.storedColorScheme
    
    var body: some View {
        Picker("Color Scheme", selection: $storedColorScheme) {
            Text("System Colors")
                .tag(StoredColorScheme.system)
            Text("Light Scheme")
                .tag(StoredColorScheme.light)
            Text("Dark Scheme")
                .tag(StoredColorScheme.dark)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

@main
struct TcgLifeCounterApp: App {
    @AppStorage(SharedSettings.storageKey)
    var storedColorScheme = SharedSettings.shared.storedColorScheme
    
    var scheme: ColorScheme {
        SharedSettings.colorScheme(
            storedColorScheme: storedColorScheme
        )
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, scheme)
        }
    }
}
