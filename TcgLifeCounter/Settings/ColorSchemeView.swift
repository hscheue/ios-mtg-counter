//
//  ColorPickerSetting.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 11/20/21.
//

import SwiftUI

struct ColorSchemeView: View {
    // TODO: Could this just be state here? Could this be observedObject?
    @AppStorage(SharedSettings.storageKey) var storedColorScheme = SharedSettings.shared.storedColorScheme
    
    var body: some View {
        HStack {
            Text("Theme")
            Picker("Color Scheme", selection: $storedColorScheme) {
                Text("System")
                    .tag(StoredColorScheme.system)
                Text("Light")
                    .tag(StoredColorScheme.light)
                Text("Dark")
                    .tag(StoredColorScheme.dark)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
