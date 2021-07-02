//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by COBE on 11/04/2021.
//

import SwiftUI

struct ContentView: View {
    let gameChoices = ["Rock","Paper","Scissors"]
    @State var shouldWin = true
    @State var randomIndex = Int.random(in: 0...2)
    @State var questionCount = 0
    @State var didWin = 0
    @State var chosenMove = ""
    var body: some View {
        NavigationView{
            VStack{
                Text("Choose your move")
                    .padding()
                Button(action: {
                    chosenMove = "Rock"
                    gameLogic()
                }, label: {
                    Text("Rock")
                })
                Button(action: {
                    chosenMove = "Paper"
                    gameLogic()
                }, label: {
                    Text("Paper")
                })
                Button(action: {
                    chosenMove = "Scissors"
                    gameLogic()
                }, label: {
                    Text("Scissors")
                })
                Text("Question count: \(questionCount)")
                    .padding()
                if shouldWin {
                    if chosenMove != "" {
                        Text("Game choose: \(gameChoices[randomIndex]) and you choose: \(chosenMove) congratulations!")
                            .padding()
                    }
                }
                else {
                    Text("Game choose: \(gameChoices[randomIndex]) and you choose: \(chosenMove) oof")
                        .padding()
                }
                Text("Your wins: \(didWin)")
                    .padding()
            }
            .navigationTitle("RockPaperScissors")
        }
    }
    func gameLogic(){
        randomIndex = Int.random(in: 0...2)
        questionCount += 1
        if questionCount == 10 {
            print(questionCount)
            print("your move: \(chosenMove)")
            print("game move: \(gameChoices[randomIndex])")
            runGame(chosenMove: chosenMove, gameMove: gameChoices[randomIndex])
            questionCount = 0
            didWin = 0
        }
        else {
            print(questionCount)
            print("your move: \(chosenMove)")
            print("game move: \(gameChoices[randomIndex])")
            runGame(chosenMove: chosenMove, gameMove: gameChoices[randomIndex])
        }
    }
    func runGame(chosenMove: String, gameMove: String){
        switch (chosenMove,gameMove) {
        case ("Rock","Scissors"):
            didWin += 1
            shouldWin = true
        case ("Scissors","Rock"):
            print("you lose")
            shouldWin = false
        case ("Paper","Rock"):
            didWin += 1
            shouldWin = true
        case ("Rock","Paper"):
            print("you lose")
            shouldWin = false
        case ("Scissors","Paper"):
            didWin += 1
            shouldWin = true
        case ("Paper","Scissors"):
            print("you lose")
            shouldWin = false
        default:
            print("draw")
            shouldWin = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
