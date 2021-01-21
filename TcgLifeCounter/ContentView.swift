//
//  ContentView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct Trailing: View {
    let players: [PlayerState]
    let restartAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: restartAction) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: DieRollView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "die.face.5.fill")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: HistoryView(players: players)
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: SettingsView()
                    .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            ) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 32))
            }
        }
    }
}

struct ContentView: View {
    @StateObject var settings = Setting()
    @State var players = [PlayerState]()
    @State var isPresentingRestartAlert = false
    
    func createPlayers(playerCount: Int) {
        players.removeAll()
        
        for i in 0..<playerCount {
            players.append(PlayerState(i, life: settings.startingLife))
        }
    }
    
    func resetPlayers() {
        AppReviewController.playerStateActivityMetricReached(playerStates: players);
        
        for player in players {
            player.history.removeAll()
            player.history.append(IntWithId(value: settings.startingLife))
        }
    }
    
    var body: some View {
        NavigationView {
            PlayersLayoutView(
                players: players,
                outwards: settings.playersFaceOutwards
            )
            .background(Color( "ViewBackgroundColor"))
            .ignoresSafeArea(edges: .horizontal)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Trailing(
                    players: players,
                    restartAction: { isPresentingRestartAlert = true })
            )
            .navigationBarColor(UIColor(named: "NavBackgroundColor"))
            .alert(isPresented: $isPresentingRestartAlert) {
                Alert(
                    title: Text("New Game"),
                    message: Text("Are you sure you want to reset player life totals?"),
                    primaryButton: Alert.Button.destructive(Text("Reset"), action: resetPlayers),
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(settings)
        // replace with onChange?
        .onReceive(settings.$playerCount, perform: createPlayers)
        .onReceive(settings.$startingLife) { lifeCount in
            resetPlayers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
