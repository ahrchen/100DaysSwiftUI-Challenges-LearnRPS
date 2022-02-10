//
//  ContentView.swift
//  LearnRPS
//
//  Created by Raymond Chen on 2/9/22.
//

import SwiftUI

enum Moves: CaseIterable {
    case Rock
    case Paper
    case Scissor
}

struct ContentView: View {
    let winState: [Moves: Moves] = [
        .Rock: .Scissor,
        .Paper : .Rock,
        .Scissor : .Paper
    ]
    
    @State var playerMove: Moves = .Rock
    @State var cpuMove: Moves = .Paper
    @State var shouldWin: Bool = false
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    func askQuestion() {
        cpuMove = Moves.allCases.randomElement()!
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
