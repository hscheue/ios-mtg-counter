//
//  LifetotalSlider.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/29/20.
//

import SwiftUI

struct PreviewView: View {
    let gesture = DragGesture(minimumDistance: 0)
        .onChanged { drag in
            print("HI")
        }
        .onEnded { drop in
            print("HI")
        }
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: 300, height: 300)
            .gesture(gesture)
    }
}

struct LifetotalSlider_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
