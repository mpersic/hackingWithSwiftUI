//
//  ContentView.swift
//  WordScramble
//
//  Created by COBE on 14/04/2021.
//

import SwiftUI

struct ContentView: View {
    //let people = ["Finn", "Leia", "Luke"]
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var userScore = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                GeometryReader { fullView in
                    List(usedWords, id: \.self) { word in
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(Color(red: Double((geo.frame(in: .global).maxY)) / Double(fullView.size.height) / 800, green: 0.6, blue: 0.4))
                                Text(word)
                                Spacer()
                            }
                            .offset(x: max(0, (geo.frame(in: .global).maxY) / fullView.size.height) * (geo.frame(in: .global).maxY), y: 0)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                        }
                    }
                }
                Text("Your score is: \(userScore)")
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform:startGame)
            .navigationBarItems(leading:
                    Button(action: startGame, label: {
                            Text("Start game")
                    })
            )
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return  
        }
        guard isSameWord(word: answer) else {
            wordError(title: "You can't use the same word", message: "Think harder!")
            return
        }
        guard isShort(word: answer) else {
            wordError(title: "Word is too short", message: "Use more letters!")
            return
        }
        // something involving number of words and their letter count would be reasonable.
        userScore += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                userScore = 0
                return
            }
        }
        fatalError("could not load start.txt from bundle")
    }
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    func isShort(word:String) -> Bool {
        return !(word.count < 3)
    }
    func isSameWord(word:String) -> Bool {
        return !(word == rootWord)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func wordError(title:String, message: String ){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
