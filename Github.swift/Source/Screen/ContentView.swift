//
//  ContentView.swift
//  Github.swift
//
//  Created by κΉμμ on 2022/06/06.
//

import Foundation
import SwiftUI

struct ContentView: View{
    
    var body: some View {
        NavigationView {
            SearchRepoView()
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
