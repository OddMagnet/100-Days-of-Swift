//
//  ContentView.swift
//  WordScramble
//
//  Created by Michael Brünen on 02.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // state
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    // alert
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle") // show length of each word
                    Text($0)
                }
                Text("Score: \(score)")     // Challenge 3 - add and show user score
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading:    // Challenge 2 - allow the user to request a new word
                Button("New word", action: startGame)
            )
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // add user input to the list
    func addNewWord() {
        // lowercase and trim the word, to make sure no duplicate are added
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // ensure the input was not empty
        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            score -= 4
            return
        }
        
        // Challenge 1 - check that input is not just the beginning of the root word
        guard isNotRootWordBeginning(word: answer) else {
            wordError(title: "Don't be lazy", message: "You can't use the beginning of the root word")
            score -= 3
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Your word contains letters not found in the root word")
            score -= 2
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "That isn't a real word or it's too short.")
            score -= 1
            return
        }
        
        // append at the beginning so new words are at the top of the list
        usedWords.insert(answer, at: 0)
        // Challenge 3 - add and show user score
        if usedWords.count > 10 {       // bonus points when finding more than 10 words
            score += answer.count * 2
        } else {
            score += answer.count
        }
        newWord = ""
    }
    
    // load data on launch
    func startGame() {
        // find URL for start.txt in the app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load content into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split string into an array of strings (on line breaks)
                let allWords = startWords.components(separatedBy: "\n")

                // pick a random word, or use "silkworm" as a default
                rootWord = allWords.randomElement() ?? "silkworm"

                return
            }
        }

        // trigger a crash and report the error if data could not be loaded
        fatalError("Could not load start.txt from bundle.")
    }
    
    // check that user input is a new word
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // Challenge 1 - check that input is not just the beginning of the root word
    func isNotRootWordBeginning(word: String) -> Bool {
        rootWord.prefix(word.count) != word
    }
    
    // check that  user input is possible
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {    // loop over rootword, check each letter with user input
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)   // remove letter if found
            } else {
                return false    // if a letter was not in the rootword or not often enough
            }
        }

        return true             // all leters are in the root word
    }
    
    // use UITextChecker to make sure the user input is a real word
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        // Challenge 1 - check that words are more than 2 letters
        return misspelledRange.location == NSNotFound && word.count > 2
    }
    
    // sets alert title and message, reset user input, then shows the alert
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        newWord = ""
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
