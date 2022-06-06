//
//  Github_swiftApp.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/05.
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
