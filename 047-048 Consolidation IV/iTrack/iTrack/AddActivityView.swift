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
    @State private var selectedActivityType: ActivityType = .work
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $activityName)
                TextField("Description", text: $activityDescription)
                Picker(selection: $selectedActivityType, label: Text("Activity type")) {
                    ForEach(ActivityType.allCases, id: \.self) { aType in
                        Text(aType.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(name: self.activityName, type: self.selectedActivityType, description: self.activityDescription)
                self.activities.items.append(activity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var activities = Activities()
    static var previews: some View {
        AddActivityView(activities: activities)
    }
}
