//
//  ContentView.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Flashcard]()
    @State private var timeRemaining = 100
    @State private var timerIsActive = true
    @State private var showingEditScreen = false
    // Wrap up - Challenge 2 - Add a settings menu with an option to put wrong cards back
    @State private var showingSettingsScreen = false
    @State private var reAppendWrongCards = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                //frame to fix layout issues on older phones, e.g. iPhone 6s and 6s plus
            
            VStack {
                Text("Time remaining: \(timeRemaining)s")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                    .shaking(shakes: timeRemaining == 0 ? 4 : 0)
                    .animation(.easeInOut)
                    // ^ Wrap up - Challenge 1 - Shake the text on timer ending
                
                ZStack {
                    ForEach(0 ..< cards.count, id: \.self) { index in
                        FlashcardView(card: self.cards[index], removal: { wasWrong in
                            withAnimation {
                                self.removeCard(at: index, cardWasWrong: wasWrong)
                            }
                        })
                            .stacked(at: index, in: self.cards.count, by: 10)
                            .allowsHitTesting(index == self.cards.count - 1)    // only allow dragging of the top card
                            .accessibility(hidden: index < self.cards.count - 1)// hide all but the top card from accessibility
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            // Edit menu
            VStack {
                HStack {
                    // Wrap up - Challenge 2 - Add a settings menu
                    Button(action: {
                        self.showingSettingsScreen = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()

                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            // Accessibility for color blind people
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1, cardWasWrong: true)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1, cardWasWrong: false)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .actionSheet(isPresented: $showingSettingsScreen) {
            // Wrap up - Challenge 2 - Add a settings menu
            ActionSheet(title: Text("Settings"),
                        message: Text("Put wrong cards back in?"),
                        buttons: [
                            .default(Text("Yes\(reAppendWrongCards ? " ⦻" : "")")) {
                                self.reAppendWrongCards = true
                            },
                            .default(Text("No\(reAppendWrongCards ? "" : " ⦻")")) {
                                self.reAppendWrongCards = false
                            }
                        ]
                    )
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCardsView()
        }
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.timerIsActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.timerIsActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.timerIsActive = true
            }
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Flashcard].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func removeCard(at index: Int, cardWasWrong: Bool) {
        guard index >= 0 else { return }
        
        let card = cards.remove(at: index)
        // Wrap up - Challenge 2 - re-append wrong cards when it's enabled in settings
        if reAppendWrongCards && cardWasWrong {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.cards.insert(card, at: 0)
            }
        }
        
        if cards.isEmpty {
            self.timerIsActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        timerIsActive = true
        loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
