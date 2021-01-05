//
//  ContentView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI
import UIKit

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                        .edgesIgnoringSafeArea(.horizontal)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct Trailing: View {
    let restartAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: restartAction) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: DieRollView().navigationBarColor(.gray)
            ) {
                Image(systemName: "die.face.5.fill")
                    .font(.system(size: 32))
            }
            
            NavigationLink(
                destination: SettingsView().navigationBarColor(.gray)
            ) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 32))
            }
        }
    }
}

struct ContentView: View {
    @StateObject var settings = Setting()
    @State var players = [Player]()
    @State var isPresentingRestartAlert = false
    
    func createPlayers(playerCount: Int) {
        players.removeAll()
        
        for _ in 0..<playerCount {
            players.append(Player(life: settings.startingLife))
        }
    }
    
    func resetPlayers() {
        for player in players {
            player.life = settings.startingLife
        }
    }
    
    var body: some View {
        NavigationView {
            PlayersLayoutView(
                players: players,
                outwards: settings.playersFaceOutwards
            )
            .ignoresSafeArea(edges: .horizontal)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Trailing(restartAction: { isPresentingRestartAlert = true })
            )
            .navigationBarColor(.gray)
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
        .onReceive(settings.$startingLife, perform: { lifeCount in
            players.forEach { $0.life = lifeCount }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
