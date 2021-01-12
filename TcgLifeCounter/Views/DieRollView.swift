//
//  DieRollView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/1/21.
//

import SwiftUI

struct RandomElementView<S>: View where S : Shape  {
    let side: CGFloat = 150
    let bgSide: CGFloat = 100
    
    
    let sides: Int
    let shape: S
    
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
                        withAnimation {
                            self.isPresentingChoice = false
                        }
                    }
                })
                .font(.system(size: 64))
                .transition(.scale)
        }
    
        
        if !isPresentingChoice {
            Text("D\(sides)")
                .padding()
                .contentShape(Circle())
                .onTapGesture {
                    setRandomValue()
                    withAnimation {
                        self.isPresentingChoice = true
                    }
                }
                .transition(.scale)
                .background(shape
                                .stroke()
                                .opacity(0.5)
                                .frame(width: bgSide, height: bgSide))
        }
    }
    
}

struct RandomElementGroupView: View {
    let fontSize: CGFloat = 32
    let side: CGFloat = 150

    var body: some View {
        Group {
            RandomElementView(sides: 2, shape: D2Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 4, shape: D4Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 6, shape: D6Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 8, shape: D8Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 10, shape: D10Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 12, shape: D12Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 20, shape: D20Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
            
            RandomElementView(sides: 100, shape: D100Shape())
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
        }
    }
}

struct DieRollView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var columns: [GridItem] =
        Array(repeating: .init(.flexible(minimum: 20, maximum: 150)), count: 2)
    
    var rows: [GridItem] =
        Array(repeating: .init(.flexible(minimum: 20, maximum: 150)), count: 2)
    
    var verticalOrientation: Bool {
        verticalSizeClass == nil || verticalSizeClass == .regular
    }
    
    var body: some View {
        if verticalOrientation {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                RandomElementGroupView()
            }
        } else {
            LazyHGrid(
                rows: rows,
                alignment: .center,
                spacing: 16
            ) {
                RandomElementGroupView()
            }
        }
        
    }
}

struct DieRollView_Previews: PreviewProvider {
    static var previews: some View {
        DieRollView()
    }
}
