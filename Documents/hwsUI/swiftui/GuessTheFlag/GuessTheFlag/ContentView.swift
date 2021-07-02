//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by COBE on 08/04/2021.
//

import SwiftUI

struct FlagImage : View {
    var country = ""
    var body : some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State public var correctAnswer = Int.random(in: 0...2)
    @State public var showingScore = false
    @State public var wrongFlag = false
    @State public var scoreTitle = ""
    @State public var wrongFlagIndex = 0
    @State public var userScore = 0
    @State private var animateCorrect = 0.0
    @State private var selectedFlag = 0
    @State private var animationAmount = 0.0
    @State private var animateOpacity = 1.0
    @State private var besidesTheCorrect = false
    @State private var besidesTheWrong = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        self.selectedFlag = number
                        self.flagTapped(number)
                        withAnimation {
                            self.animateOpacity = 0.25
                            if number == self.correctAnswer {
                                self.animateCorrect += 360
                                self.besidesTheCorrect = true
                            }
                            else {
                                self.besidesTheWrong = true
                            }
                        }
                    })
                    {
                        FlagImage(country: self.countries[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                    }
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animateCorrect : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(number != self.correctAnswer && self.besidesTheCorrect ? self.animateOpacity : 1)
                    .background(self.besidesTheWrong && self.selectedFlag == number ? Capsule(style: .circular).fill(Color.red).blur(radius: 30) : Capsule(style: .circular).fill(Color.clear).blur(radius: 0))
                    .opacity(self.besidesTheWrong && self.selectedFlag != number ? self.animateOpacity : 1)
                    
                }
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {
            if self.wrongFlag {
                return Alert(title: Text(scoreTitle), message: Text("Wrong flag, that was flag of \(countries[wrongFlagIndex])"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
            else {
                return Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
        
    }
    
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            wrongFlag = false
            scoreTitle = "Correct"
            userScore += 1
        }
        else {
            scoreTitle = "Wrong"
            userScore = 0
            wrongFlagIndex = number
            wrongFlag = true
        }
        showingScore = true
    }
    
    func askQuestion(){
        besidesTheCorrect = false
        besidesTheWrong = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

