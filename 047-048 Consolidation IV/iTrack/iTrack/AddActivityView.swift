//
//  AddActivityView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var activityName = ""
    @State private var activityDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $activityName)
                TextField("Name", text: $activityDescription)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(name: self.activityName, description: self.activityDescription)
                self.activities.activities.append(activity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var activities = Activities(activities: loadData())
    static var previews: some View {
        AddActivityView(activities: activities)
    }
}
