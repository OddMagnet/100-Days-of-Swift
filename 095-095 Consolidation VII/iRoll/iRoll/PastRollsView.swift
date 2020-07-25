//
//  PastRollsView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct PastRollsView: View {
    @EnvironmentObject var settings: Settings
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: []) var diceRolls: FetchedResults<DiceRoll>

    var body: some View {
        NavigationView {
            List {
                if !diceRolls.isEmpty {
                    HStack {
                        Text("Sides")
                            .frame(minWidth: 50)
                        Text("Results")
                    }
                    .font(.headline)

                    ForEach(diceRolls) { roll in
                        HStack {
                            Text("\(roll.sides)")
                                .padding(5)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .frame(minWidth: 50)
                            
                            Text("\(roll.wrappedRolls.map{ String($0) }.joined(separator: ", "))")
                        }
                    }
                } else {
                    Text("No past rolls")
                }
            }
            .navigationBarTitle("Past Rolls")
        }
    }
}

struct PastRollsView_Previews: PreviewProvider {
    static var previews: some View {
        PastRollsView()
    }
}
