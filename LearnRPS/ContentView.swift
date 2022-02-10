//
//  ContentView.swift
//  LearnRPS
//
//  Created by Raymond Chen on 2/9/22.
//

import SwiftUI

enum Moves: String, CaseIterable {
    case Rock = "👊🏻"
    case Paper = "🖐🏻"
    case Scissor = "✌🏻"
}

struct ContentView: View {
    let winState: [Moves: Moves] = [
        .Rock: .Paper,
        .Paper : .Scissor,
        .Scissor : .Rock
    ]
    let loseState: [Moves: Moves] = [
        .Rock: .Scissor,
        .Paper : .Rock,
        .Scissor : .Paper
    ]
    let possibleMoves: [Moves] = [.Rock, .Paper, .Scissor]
    
    private let numberOfPlaysPerGame = 10
    @State private var gameOver = false
    @State private var gamesPlayed: Int = 0
    @State private var playerScore: Int = 0
    @State private var cpuMove: Moves = .Paper
    @State private var shouldWin: Bool = false
    @State private var shouldWinText: String = ""
    @State private var gameOverMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(playerScore)")
                    .font(.system(size: 50))
                Spacer()
                
                Text("CPU Choice: \(cpuMove.rawValue)")
                    .font(.system(size: 25))
                Text(shouldWinText)
                Spacer()
                
                Text("Choices")
                HStack {
                    ForEach(possibleMoves, id:\.self) { move in
                        Button(move.rawValue) {
                            moveTapped(move)
                        }
                    }
                }
                .font(.system(size: 50))
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("Reset", action: reset)
            } message : {
                Text(gameOverMessage)
            }
            
        }.onAppear { self.askQuestion() }
        .navigationTitle("Learn to Play: Rock Paper Scissor")
    }
    
    func moveTapped(_ move: Moves) {
        gamesPlayed += 1

        if winState[cpuMove] == move && shouldWin {
            playerScore += 1
        } else if loseState[cpuMove] == move && !shouldWin  {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        if gamesPlayed == numberOfPlaysPerGame {
            gameOverMessage = "Player Score: \(playerScore) | Possible score: \(gamesPlayed)"
            gameOver = true
        }
        askQuestion()
    }
    
    func askQuestion() {
        cpuMove = Moves.allCases.randomElement()!
        shouldWin = Bool.random()
        
        if shouldWin {
            shouldWinText = "You should win this game"
        } else {
            shouldWinText = "You should lose this game"
        }
    }
    
    func reset() {
        gamesPlayed = 0
        playerScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
