//
//  ActivityDetailView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activities.items[index].name)
            .font(.largeTitle)
            
            Text(activities.items[index].description)
                .padding()
            
            Text("Times completed: \(activities.items[index].timesCompleted)")
                .padding()
            
            Spacer()
            
            Button(action: {
                self.activities.items[self.index].completed()
            }) {
                Spacer()
                Text("Completed")
                Spacer()
            }
            .padding()
            .background(Color.green)
            
        }
        .padding()
        .navigationBarTitle(activities.items[index].type.rawValue)
        
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), index: 0)
        //ActivityDetailView(index: 0)
    }
}
