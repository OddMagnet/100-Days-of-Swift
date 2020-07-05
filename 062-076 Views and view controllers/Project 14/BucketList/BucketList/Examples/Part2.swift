//
//  Part2.swift
//  BucketList
//
//  Created by Michael Brünen on 05.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct Part2: View {
    @State private var isUnlocked = false
    
    var body: some View {
        
        Section(header: Text("Part 2")) {
            
            NavigationLink("Integrating MapKit with SwiftUI", destination:
                MapView()
                    .edgesIgnoringSafeArea(.all)
            )
            
            NavigationLink("Communicating with a MapKit coordinator", destination:
                MapView()
                    .edgesIgnoringSafeArea(.all)
            )
            
            NavigationLink("Using Touch ID and Face ID with SwiftUI", destination:
                VStack {
                    if self.isUnlocked {
                        Text("Unlocked")
                    } else {
                        Text("Locked")
                    }
                }
                .onAppear(perform: authenticate)
            )
            
        }
    }
    
    func authenticate() {
        // Create instance of LAContext to query biometric status and perform the authentication
        let context = LAContext()
        var error: NSError?
        
        // check if device has Touch or Face ID, pass a pointer to error variable
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // do the request for authentication, with completion closure
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "We need to unlock your data"  // message for Touch ID gets passed, Face ID in plist
            ) { success, authenticationError in
                // dispatch the completion status
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // a problem happened
                    }
                }
            }
            context.eva
        } else {
            // no biometrics
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
