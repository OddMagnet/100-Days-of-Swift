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
            }
            .navigationBarTitle("WordScramble")//rootWord)
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure no duplicate are added
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // ensure the input was not empty
        guard answer.count > 0 else {
            return
        }

        // extra validation to come

        // append at the beginning so new words are at the top of the list
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
