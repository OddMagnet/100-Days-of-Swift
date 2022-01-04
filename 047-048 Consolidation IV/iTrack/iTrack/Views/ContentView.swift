//
//  ContentView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = Activities()
    @State private var addNewActivity = false
    
    var body: some View {
        NavigationView {
            List(data.activities) { activity in
                NavigationLink {
                    ActivityDetailView(data: data, activity: activity)
                } label: {
                    HStack {
                        Text("\(activity.type.rawValue) \(activity.name)")

                        Spacer()

                        Text(String(activity.timesCompleted))
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(color(for: activity))
                            .clipShape(Capsule())
                    }
                }
            }
            .navigationTitle("iTrack")
            .toolbar {
                Button {
                    addNewActivity = true
                } label: {
                    Label("Add new activity", systemImage: "plus")
                }
            }
            .sheet(isPresented: $addNewActivity) {
                AddActivityView(data: data)
            }
        }
    }

    func color(for activity: Activity) -> Color {
        switch activity.timesCompleted {
            case 00 ..< 03: return .red
            case 03 ..< 10: return .orange
            case 11 ..< 20: return .green
            case 21 ..< 50: return .blue
            default:        return .indigo
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        data.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
