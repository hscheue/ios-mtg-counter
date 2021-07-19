//
//  TEST_EntryCounter.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 6/20/21.
//

import SwiftUI

struct EntryCounterClickArea: View {
    @State var counter = 0
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: width, y: 0))
                    path.addLine(to: CGPoint(x: width, y: height))
                }
                .fill(Color(white: 0.9))
                .onTapGesture {
                    counter += 1
                }
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                }
                .fill(Color(white: 0.85))
                .onTapGesture {
                    counter -= 1
                }
                
                Text("\(counter)")
                    .position(x: width / 2, y: height / 2)
                    .font(.system(size: 24.0))
                    .foregroundColor(.black)
                
                Text("+")
                    .font(.system(size: 12.0))
                    .position(x: width, y: 0)
                    .offset(x: -width / 11, y: height / 11)
                    .foregroundColor(Color(white: 0.4))
                
                Text("-")
                    .font(.system(size: 12.0))
                    .position(x: 0, y: height)
                    .offset(x: width / 11, y: -height / 11)
                    .foregroundColor(Color(white: 0.2))
            }
        }
    }
}

struct EntryCounterClickArea_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            EntryCounterClickArea().frame(width: 128, height: 128)
        }
    }
}

let minimizedSize: CGFloat = 25

struct EntryCounterPosition: View {
    private var geo: GeometryProxy
    @State private var size: CGFloat = minimizedSize
    @State private var position: CGSize
    @State private var offset = CGSize.zero

    init(geo: GeometryProxy) {
        let sideLength: CGFloat = 25;
        self.geo = geo
        self._size = State(initialValue: sideLength);
        self._position = State(
            initialValue: CGSize(
                width: sideLength / 2,
                height: geo.size.height / 2
            )
        )
    }
    

    var body: some View {
        EntryCounterClickArea()
            .frame(width: size, height: size)
            .position(x: position.width, y: position.height)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                        withAnimation {
                            self.size = 100
                        }
                    }
                    .onEnded { _ in
                        let anchorW = self.size / 2
                        let anchorH = self.geo.size.height / 2
                        let w2 = position.width + offset.width
                        let h2 = position.height + offset.height
                        if (abs(anchorW - w2) < 30 && abs(anchorH - h2) < 30) {
                            size = 25
                            self.position = CGSize(width: self.size / 2, height: anchorH)
                        } else {
                            self.position = CGSize(width: w2, height: h2)
                        }
                        self.offset = .zero
                    }
            )
    }
}

struct TEST_EntryCounterPosition: View {
    var body: some View {
        GeometryReader { geo in
            Color.red
            EntryCounterPosition(geo: geo)
            Text("HI")
        }
    }
}

struct TEST_EntryCounter_Previews: PreviewProvider {
    static var previews: some View {
        TEST_EntryCounterPosition()
    }
}
