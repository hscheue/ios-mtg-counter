//
//  PlayerState.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/13/21.
//

import SwiftUI
import Combine

struct IntWithId: Identifiable {
    let id = UUID().uuidString
    var value: Int
}

// TODO: Backwards animation in matched geometry is preview only!
// TODO: replace state with enums or ints for incrementing state instead
class PlayerState: ObservableObject, Identifiable {
    static func == (lhs: PlayerState, rhs: PlayerState) -> Bool {
        lhs.id == rhs.id
    }
    let name: String
    let starting: Int
    private var cancellable = Set<AnyCancellable>()
    @Published var history = [IntWithId]([IntWithId(value: 20)])
    @Published var anyChange: Void = ()
    var isChanging = false
    var changeAnimated = true
    
    public var previous: IntWithId? {
        self.history.count > 1
            ? self.history[self.history.count - 2]
            : nil
    }
    
    public var current: IntWithId? {
        self.history.count > 0
            ? self.history[self.history.count - 1]
            : nil
    }
    
    public func inc(by: Int) {
        self.anyChange = ()
        if isChanging {
            history[history.count - 1].value += by
        } else if isChanging != changeAnimated {
            let newValue = IntWithId(value: history.last!.value)
            withAnimation {
                objectWillChange.send()
                changeAnimated = false
                isChanging = true
                history.append(newValue)
            }
            history[history.count - 1].value += by
        }
    }
    
    public func commit() {
        withAnimation {
            objectWillChange.send()
            isChanging = false
            changeAnimated = true
        }
    }
    
    public func revert() {
        guard history.count > 1 else {
            return
        }
        objectWillChange.send()
        changeAnimated = false
        withAnimation {
            objectWillChange.send()
            history.remove(at: history.count - 1)
            isChanging = false
            changeAnimated = true
        }
    }
    
    convenience init(_ index: Int, life: Int) {
        self.init(index, life: life, history: [life])
    }
    
    convenience init() {
        self.init(Int.random(in: 0..<10), life: 20, history: [20])
    }
    
    init(_ index: Int, life: Int, history: [Int]) {
        self.name = "Player \(index + 1)"
        self.starting = life
        self.history = [IntWithId]([IntWithId(value: life)])
        
        for h in history {
            self.history.append(IntWithId(value: h))
        }
        
        $anyChange
            .debounce(for: 2.0, scheduler: RunLoop.main)
            .sink {
                if self.previous?.value == self.current?.value {
                    self.revert()
                } else {
                    self.commit()
                }
            }
            .store(in: &cancellable)
    }
}
