//
//  LifetotalSlider.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/29/20.
//

import SwiftUI

struct LifetotalSliderView: View {
    var visibility: Bool
    
    var body: some View {
        if visibility {
            HStack(spacing: 64) {
                ForEach(0..<3, id: \.self) { i in
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: .infinity, height: 20)
                }
            }
        }
    }
}

struct LifetotalSliderGesture: Gesture {
    @Binding var visibility: Bool
    var anyStateValueHere: GestureState<Bool>

    var body: some Gesture {
        let dragGesture = DragGesture()
            .updating(anyStateValueHere) { value, state, transaction in
                state = true
            }
        
//        let longPressGesture = LongPressGesture()
//            .updating(visibility) { bool, state, transaction in
//                state = bool
//            }
        
        return dragGesture
    }
}

struct LifetotalSliderModifier: ViewModifier {
    @State var visibility = false
    @GestureState var anyStateValueHere: Bool = false
    
    func body(content: Content) -> some View {
        content
            .overlay(LifetotalSliderView(
                        visibility: visibility))
            .gesture(LifetotalSliderGesture(
                        visibility: $visibility,
                        anyStateValueHere: $anyStateValueHere))
    }
}

struct PreviewView: View {
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: 300, height: 300)
            .modifier(LifetotalSliderModifier())
    }
}

struct LifetotalSlider_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
