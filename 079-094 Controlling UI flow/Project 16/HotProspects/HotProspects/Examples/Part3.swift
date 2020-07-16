//
//  Part3.swift
//  HotProspects
//
//  Created by Michael Brünen on 14.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import UserNotifications

struct Part3: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        Section(header: Text("Part 3")) {
            
            NavigationLink("Creating context menus", destination:
                VStack {
                    Text("Long press me")
                        .padding()
                        .background(backgroundColor)
                        .contextMenu {
                            Button(action: {
                                self.backgroundColor = .red
                            }) {
                                Text("Red")
                                Image(systemName: backgroundColor == Color.red ? "checkmark.circle.fill" : "circle")
                            }
                            Button(action: {
                                self.backgroundColor = .green
                            }) {
                                Text("Green")
                                Image(systemName: backgroundColor == Color.green ? "checkmark.circle.fill" : "circle")
                            }
                            Button(action: {
                                self.backgroundColor = .blue
                            }) {
                                Text("Blue")
                                Image(systemName: backgroundColor == Color.blue ? "checkmark.circle.fill" : "circle")
                            }
                    }
                }
            )
            
            NavigationLink("Scheduling local notifications", destination:
                VStack {
                    Button("Request Permission") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }

                    Button("Schedule Notification") {
                        let content = UNMutableNotificationContent()
                        content.title = "Feed the dog"
                        content.subtitle = "It looks hungry"
                        content.sound = UNNotificationSound.default
                        
                        // show notification 5s from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                        
                        // don't care about identifier -> use a random one
                        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                            content: content,
                                                            trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            )

            NavigationLink("Placeholder", destination:
                Text("Placeholder")
            )

        }
    }
}

struct Part3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part3()
            }
        }
    }
}
