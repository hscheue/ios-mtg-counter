//
//  DieRollView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/1/21.
//

import SwiftUI

struct RandomElementView: View {
    let sides: Int
    
    @State var randomChoice: Int = -1
    @State var isPresentingChoice = false
    
    func setRandomValue() {
        randomChoice = (1...sides).randomElement() ?? -1
    }
    
    var body: some View {
        if isPresentingChoice {
            Text("\(randomChoice)")
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.isPresentingChoice = false
                    }
                })
        }
        
        if !isPresentingChoice {
            Text("D\(sides)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder())
                .onTapGesture {
                    setRandomValue()
                    self.isPresentingChoice = true
                }
        }
    }
    
}

struct DieRollView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let dice = [2, 4, 6, 8, 10, 12, 20, 100]
    
    var columns: [GridItem] =
        Array(repeating: .init(.flexible(minimum: 20, maximum: 200)), count: 2)
    
    var rows: [GridItem] =
        Array(repeating: .init(.flexible(minimum: 20, maximum: 200)), count: 2)
    
    var verticalOrientation: Bool {
        verticalSizeClass == nil || verticalSizeClass == .compact
    }
    
    var body: some View {
        if verticalOrientation {
            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                ForEach(dice, id: \.self) {
                    RandomElementView(sides: $0)
                        .font(.system(size: 64))
                        .frame(width: 200, height: 128)
                }
            }
        } else {
            LazyHGrid(rows: rows, alignment: .center, spacing: 16) {
                ForEach(dice, id: \.self) {
                    RandomElementView(sides: $0)
                        .font(.system(size: 64))
                        .frame(width: 200, height: 128)
                }
            }
        }
        
    }
}

struct DieRollView_Previews: PreviewProvider {
    static var previews: some View {
        DieRollView()
    }
}
