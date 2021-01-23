//
//  DebounceSettingView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/22/21.
//

import SwiftUI

struct DebounceSettingView {
    let values: [Double] = [2, 3, 5, 7, 9, 12, 15];
    let title = "Debounce Timer"
    let description = "Each time you change a players life total, this value is the amount of seconds the app waits until storing it in history."
    
    var selection: Binding<Int> { .init(
            get: { values.firstIndex(of: setting.debounceValue) ?? 0 },
            set: { setting.debounceValue = values[$0] }
    )}
    @State var showingInfoDialog = false
    @EnvironmentObject var setting: Setting
}

extension DebounceSettingView {
    var range: ClosedRange<Int> { 0 ... self.values.count - 1 }
    var value: Double { self.values[self.selection.wrappedValue] }
    var display: String { String(format: "%.2G s", self.value) }
}

extension DebounceSettingView {
    func save(_ change: Double) { self.setting.debounceValue = change }
    func showDialog() { self.showingInfoDialog = true }
}

extension DebounceSettingView: View {
    var body: some View {
        Stepper(value: self.selection, in: self.range) {
            HStack {
                Button(action: self.showDialog) {
                    Image(systemName: "info.circle")
                }
                Text(self.title)
                Spacer()
                Text(self.display)
            }
        }
        .alert(isPresented: self.$showingInfoDialog) {
            Alert(title: Text(self.title), message: Text(self.description))
        }
    }
}

struct DebounceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DebounceSettingView()
            .previewLayout(.sizeThatFits)
            .environmentObject(Setting())
    }
}
