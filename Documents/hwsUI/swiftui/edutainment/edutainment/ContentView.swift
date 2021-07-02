//
//  ContentView.swift
//  edutainment
//
//  Created by COBE on 18/04/2021.
//

import SwiftUI

struct QuestionView: View {
    var questionText: String
    
    var body: some View {Text(questionText)
    }
}
struct selectPracticeNumberView: View {
    @State private var selectedNumber = 0
    var body: some View {
        Form
        {
            Stepper("Which number do you want", value: $selectedNumber, in: 1...12)
            Text("You choose \(selectedNumber)")
        }
    }
    
}

struct ContentView: View {
    
    @State private var currentQuestion = 0
    var questionNumberChoices = ["5", "10", "15", "20", "All"]
    @State private var answer = ""
    @State private var numberOfQuestions = "5"
    @State private var selectedNumber = Int.random(in: 1...12)
    @State private var gameIsActive = false
    @State private var playAgain = false
    @State private var userScore = 0
    @State private var broj = Int.random(in: 1...12)
    @State var generatedQuestions = [Question]()
    var body: some View {
        Group {
            if !gameIsActive{
                NavigationView{
                    VStack{
                        Form {
                            Section(header: Text("Which number do you want to practice")){
                                Stepper("You choose number \(selectedNumber)", value: $selectedNumber, in: 1...12)
                            }
                        }
                        Section(header: Text("Please select the number of questions you want")){
                            Picker("", selection: $numberOfQuestions) {
                                ForEach(questionNumberChoices, id: \.self) {
                                    //Text(self.questionNumberChoices[$0])
                                    Text($0)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        Form{
                            Text("You selected: \(numberOfQuestions) questions")
                            Button("Play"){
                                self.gameIsActive.toggle()
                                
                                let questionCount = Int(numberOfQuestions) ?? 24
                                generatedQuestions = []
                                if questionCount != 24 {
                                    for _ in 0..<questionCount {
                                        let randomNumber = Int.random(in: 1...12)
                                        let text = "How much is \(self.selectedNumber)*\(randomNumber)"
                                        let answer = selectedNumber * randomNumber
                                        self.generatedQuestions.append(Question(text: text, answer: answer))
                                    }
                                }
                                else {
                                    for i in 0..<questionCount {
                                        let randomNumber = Int.random(in: 1...12)
                                        var text = "How much is \(i)*\(randomNumber)"
                                        let answer = i * randomNumber
                                        self.generatedQuestions.append(Question(text: text, answer: answer))
                                        text = "How much is \(randomNumber)*\(i)"
                                        self.generatedQuestions.append(Question(text: text, answer: answer))
                                        self.generatedQuestions.shuffle()
                                    }
                                }
                            }
                        }
                        
                    }
                    .navigationBarTitle("Edutainment")
                }
            }
            else {
                NavigationView{
                    VStack{
                        let questionCount = Int(numberOfQuestions) ?? 24
                        ForEach(0 ..< generatedQuestions.count ) { number in
                            if number == generatedQuestions.count , currentQuestion == number {
                                Text("your score is \(userScore)")
                                Button("Play again?") {
                                    self.playAgain.toggle()
                                    generatedQuestions = []
                                    for _ in 0..<questionCount {
                                        let randomNumber = Int.random(in: 1...12)
                                        let text = "How much is \(self.selectedNumber)*\(randomNumber)"
                                        let answer = selectedNumber * randomNumber
                                        self.generatedQuestions.append(Question(text: text, answer: answer))
                                    }
                                    broj = Int.random(in: 1...12)
                                    currentQuestion = 0
                                    answer = ""
                                    userScore = 0
                                }
                                .animation(.easeOut)
                                .background(Color.green)
                                Button("New settings") {
                                    self.gameIsActive.toggle()
                                }
                                .background(Color.orange)
                            }
                            
                            else if currentQuestion == number
                            {
                                QuestionView(questionText: generatedQuestions[currentQuestion].text)
                                TextField("Enter your number", text: $answer)
                                Button("Next question"){
                                    
                                    if(self.generatedQuestions[number].answer == Int(answer)){
                                        userScore += 1
                                    }
                                    broj = Int.random(in: 1...12)
                                    currentQuestion += 1
                                    answer = ""
                                }
                                .frame(width: 200, height: 200)
                                        .background( Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 60))
                                
                            }
                        }
                        
                    }
                    .navigationBarTitle("Edutainment")
                }
            }
        }
    }
    func generateQuestions(){
        let questionCount = Int(numberOfQuestions) ?? 144
        generatedQuestions = []
        for _ in 0..<questionCount {
            let randomNumber = Int.random(in: 1...12)
            let text = "How much is \(self.selectedNumber)*\(randomNumber)"
            let answer = selectedNumber * randomNumber
            self.generatedQuestions.append(Question(text: text, answer: answer))
        }
    }
}


struct Question {
    var text: String
    var answer: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
