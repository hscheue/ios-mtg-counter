//
//  SettingsView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/24/20.
//  https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009542

import SwiftUI

struct LifeEditorView: View {
    @EnvironmentObject var setting: Setting
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
            
            setting.customValue = nextInt
            errorMessage = ""
            return
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
    @AppStorage("dciNumber") var dciNumber: String = ""
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
                        Text("Standard")
                            .tag(20)
                        Text("Brawl")
                            .tag(25)
                        Text("Commander")
                            .tag(40)
                        Text("Custom")
                            .tag(setting.customValue)
                    }
                } else {
                    LifeEditorView(value: String(setting.customValue))
                }
                Image(systemName: isPresentingLifeEditor
                        ? "checkmark.circle" : "square.and.pencil")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(
                        isPresentingLifeEditor
                            ? "Save custom life total"
                            : "Change lifetotal from \(setting.customValue)"
                    )
                    .onTapGesture {
                        setting.startingLife = setting.customValue
                        isPresentingLifeEditor.toggle()
                    }
            }
            ColorPreferencePickerView()
            Toggle("Players facing outwards", isOn: $setting.playersFaceOutwards)
            DebounceSettingView()
            
            LeaveFeedbackSectionView()

            Section(header: Text("Other")) {
                HStack {
                    Text("DCI#:")
                    TextField("Remember my DCI number", text: $dciNumber)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                TimerSettingsView()
            }
            
        }
        .pickerStyle(SegmentedPickerStyle())
        .navigationBarItems(trailing: DoneButton())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(Setting())
    }
}

struct LeaveFeedbackSectionView: View {
    var body: some View {
        Section(header: Text("Leave feedback")) {
            Button(action: {
                AppReviewController.openManualReview()
            }, label: {
                Label("Write a review in the App Store", systemImage: "star.leadinghalf.fill")
            })
        }
    }
}
