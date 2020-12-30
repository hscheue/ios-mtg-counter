//
//  SettingsView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/24/20.
//

import SwiftUI

struct LifeEditorView: View {
    @Binding var customValue: String
    
    @State var value: String
    @State var errorMessage = ""
    
    func validated(_ next: String) {
        withAnimation {
            guard let nextInt = Int(next) else {
                errorMessage = "Value is not a number"
                return
            }
            
            guard nextInt > 0 else {
                errorMessage = "Value should be greater than 0"
                return
            }
            
            guard ![20,25,40].contains(nextInt) else {
                errorMessage = "Value is already a provided choice"
                return
            }
            
            customValue = value
            errorMessage = ""
            return
        }
    }
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            TextField(
                "Lifetotal",
                text: $value
            )
            .onChange(of: value, perform: validated)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .keyboardType(.numberPad)
            .foregroundColor(errorMessage.isEmpty ? .blue : .red)
            
            if errorMessage != "" {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .animation(.default)
            }
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var setting: Setting
    @State var customValue = "30"
    @State var isPresentingLifeEditor = false
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Current Setting")
                    .font(.title)
                
                HStack {
                    Text("Players: \(setting.playerCount)")
                    Text("Lifetotal: \(setting.startingLife)")
                }
            }
            Picker("Players", selection: $setting.playerCount) {
                ForEach(2...6, id: \.self) {
                    Text("\($0) Players").tag($0)
                }
            }
            HStack {
                if !isPresentingLifeEditor {
                    Picker("Lifetotal", selection: $setting.startingLife) {
                        Text("Standard").tag(20)
                        Text("Brawl").tag(25)
                        Text("Commander").tag(40)
                        Text("Custom").tag(Int(customValue) ?? 30)
                    }
                } else {
                    LifeEditorView(
                        customValue: $customValue,
                        value: customValue)
                }
                Image(systemName: "square.and.pencil")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(
                        "Change lifetotal from \(customValue)"
                    )
                    .onTapGesture {
                        setting.startingLife = Int(customValue) ?? 0
                        isPresentingLifeEditor.toggle()
                    }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Setting())
        SettingsView()
            .environmentObject(Setting())
    }
}

