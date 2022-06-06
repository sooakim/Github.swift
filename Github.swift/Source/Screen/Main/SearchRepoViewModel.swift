//
//  SearchRepoViewModel.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Combine

final class SearchRepoViewModel: ObservableObject{
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    @Published private(set) var repos: [RepoResponse] = []
    
    init(){
        let repoRepository = RepoRepository()
     
        $searchText.debounce(for: .milliseconds(700), scheduler: DispatchQueue.main)
            .filter{ !$0.isEmpty }
            .flatMap{ [repoRepository] (text: String) in
                ConcurrencyPublisher{
                    try await repoRepository.fetchRepos(searchText: text)
                }.eraseToAnyPublisher()
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (repos: [RepoResponse]) in
                self?.repos = repos
            })
            .store(in: &subscriptions)
    }
}
