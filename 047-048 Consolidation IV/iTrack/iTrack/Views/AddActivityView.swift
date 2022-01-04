//
//  AddActivityView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var data: Activities
    @State private var activityName = ""
    @State private var activityType = ActivityType.learning
    @State private var activityDescription = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $activityName)
                    Picker("Activity Type", selection: $activityType) {
                        ForEach(ActivityType.allCases, id: \.self) { type in
                            Text(type.name)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Description", text: $activityDescription)
                }

                Spacer()

                Button("Dismiss") {
                    dismiss()
                }
                .padding(.bottom)
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Save") {
                    let trimmedName = activityName.trimmingCharacters(in: .whitespaces)
                    guard trimmedName.isEmpty == false else { return }

                    let activity = Activity(
                        name: trimmedName,
                        type: .learning,
                        description: activityDescription
                    )
                    data.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var activities = Activities()
    static var previews: some View {
        AddActivityView(data: Activities())
    }
}
