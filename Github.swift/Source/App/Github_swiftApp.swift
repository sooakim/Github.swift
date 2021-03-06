//
//  Github_swiftApp.swift
//  Github.swift
//
//  Created by κΉμμ on 2022/06/05.
//

import SwiftUI

@main
struct Github_swiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
