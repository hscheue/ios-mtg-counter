//
//  DoneButton.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 9/12/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

import Combine
import UIKit


/// Publisher to read keyboard changes.
protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

struct DoneButton: View, KeyboardReadable {
    @State var isKeyboardVisible = false

    var body: some View {
        Button("Done", action: hideKeyboard)
        .onReceive(keyboardPublisher) {
            isKeyboardVisible = $0
        }
        .foregroundColor(isKeyboardVisible ? .primary : .secondary)
        .disabled(!isKeyboardVisible)
        .colorScheme(.dark)
    }
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TextField("", text: .constant("Value"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: DoneButton(isKeyboardVisible: true))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewDisplayName("Disabled Button")
        // .environmentObject(Setting())
        
        NavigationView {
            TextField("", text: .constant("Value"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: DoneButton(isKeyboardVisible: false))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewDisplayName("Enabled Button")

    }
}
