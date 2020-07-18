//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Michael Brünen on 17.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import UserNotifications
import CodeScanner

enum FilterType {
    case none, contacted, uncontacted
}

// Wrap up - challenge 3 - add sorting
enum SortingType: String, CaseIterable {
    case none = "None"
    case name = "Name"
    case recent = "Recent"
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    // Wrap up - challenge 3 - add sorting
    @State private var isShowingSortingSheet = false
    @State var sortType: SortingType = .none

    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    // Wrap up - challenge 3 - add sorting
    var sortedProspects: [Prospect] {
        switch sortType {
        case .none:
            return filteredProspects
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .recent:
            return filteredProspects.sorted { $0.createdOn > $1.createdOn }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack {
                        // Wrap up - Challenge 1 - contact status indicator
                        Image(systemName: prospect.isContacted
                            ? "checkmark.seal.fill"
                            : "xmark.seal.fill"
                        )
                            .font(.title)
                            .foregroundColor(prospect.isContacted ? .green : .red)
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            // Wrap up - challenge 3 - add sorting
            .navigationBarItems(leading: Button(action: {
                self.isShowingSortingSheet = true
            }) {
                Image(systemName: self.sortType == .none
                    ? "line.horizontal.3.decrease.circle"
                    : "line.horizontal.3.decrease.circle.fill"
                )
                Text("Sort")
            }, trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Odd Magnet\noddmagnet@gmail.com", completion: self.handleScan)
            }
            // Wrap up - challenge 3 - add sorting
            .actionSheet(isPresented: $isShowingSortingSheet) {
                ActionSheet(title: Text("Sort by: "), message: nil, buttons:
                    SortingType.allCases.map { type in
                        ActionSheet.Button.default(Text(type.rawValue)) {
                            self.sortType = type
                        }
                    }
                    + [.cancel()]
                )
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        // handle the result
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            person.createdOn = Date()
            
            self.prospects.add(person)

        case .failure(let error):
            switch error {
            case .badInput:
                print("No camera available")
            case .badOutput:
                print("Could not read code")
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        // create a closure that can be called later
        let addRequest = {
            // create the content
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            // set a trigger
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            // testing trigger:
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            // finish request creation and add it to the notification center
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            notificationCenter.add(request)
        }
        
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Can't add notification, authorization was denied")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
