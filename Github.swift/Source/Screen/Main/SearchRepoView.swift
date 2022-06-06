//
//  SearchRepoView.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/05.
//

import SwiftUI
import CoreData
import Combine

struct SearchRepoView: View {
    @StateObject var viewModel = SearchRepoViewModel()

    var body: some View {
        List {
            ForEach(viewModel.repos) { item in
                Text("\(item.name)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Github Search")
        .searchableCompat(text: $viewModel.searchText)
    }

}

struct SearchRepoView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepoView()
    }
}
