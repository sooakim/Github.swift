//
//  RepoRepository.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Moya

final class RepoRepository{
    func fetchRepos(searchText: String) async throws -> [RepoResponse]{
        do {
            let response: PaginatedResponse<RepoResponse> = try await NetworkService.shared.repoApi.concurrency.requestWithDecode(.searchRepos(query: searchText, sort: "stars"))
            return response.items
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
}
