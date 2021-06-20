//
//  TEST_EntryCounter.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 6/20/21.
//

import SwiftUI

struct EntryCounterStyles: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(white: 0.8)
                // replace with stroke? or google stroke method here
                RoundedRectangle(cornerRadius: 25)
                    .frame(
                        width: geo.size.width * 0.8,
                        height: geo.size.height * 0.8)
                    .foregroundColor(.clear)
                    .border(Color.black)
                
                Text("RED")
            }
        }
    }
}

struct EntryCounterStyles_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            EntryCounterStyles()
                .frame(width: 128, height: 128)
        }
    }
}

struct EntryCounterClickArea: View {
    @State var counter = 0
    var body: some View {
        ZStack {
            Color.blue
            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 128, y: 0))
                path.addLine(to: CGPoint(x: 128, y: 128))
            }
            .fill(Color.black)
            .onTapGesture {
                counter += 1
            }
            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 128, y: 128))
                path.addLine(to: CGPoint(x: 0, y: 128))
            }
            .fill(Color.orange)
            .onTapGesture {
                counter -= 1
            }
            
            Text("Count: \(counter)")
                .foregroundColor(.red)
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
        Color.green
            .frame(width: 25, height: 25)
            .position(x: position.width, y: position.height)
        Color.orange
            .frame(width: 25, height: 25)
            .position(x: offset.width, y: offset.height)
        Color.blue
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
