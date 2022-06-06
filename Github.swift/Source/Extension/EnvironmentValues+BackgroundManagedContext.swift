//
//  EnvironmentValues+BackgroundManagedObjectContextKey.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import SwiftUI
import CoreData

private struct BackgroundManagedObjectContextKey: EnvironmentKey{
    static let defaultValue = PersistenceController.shared.container.newBackgroundContext()
}

extension EnvironmentValues{
    var backgroundManagedObjectContext: NSManagedObjectContext{
        get{
            self[BackgroundManagedObjectContextKey.self]
        }
        set{
            self[BackgroundManagedObjectContextKey.self] = newValue
        }
    }
}
