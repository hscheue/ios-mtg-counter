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
                .contentShape(Circle())
                .onTapGesture {
                    setRandomValue()
                    self.isPresentingChoice = true
                }
        }
    }
    
}

struct RandomElementGroupView: View {
    let side: CGFloat = 150
    let bgSide: CGFloat = 100
    let fontSize: CGFloat = 32
    
    var body: some View {
        Group {
            RandomElementView(sides: 2)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D2Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 4)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D4Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 6)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D6Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 8)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D8Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 10)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D10Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 12)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D12Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 20)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D20Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
            
            RandomElementView(sides: 100)
                .font(.system(size: fontSize))
                .frame(width: side, height: side)
                .background(
                    D100Shape()
                        .stroke()
                        .opacity(0.5)
                        .frame(width: bgSide, height: bgSide))
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
