//
//  RepoApi.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Moya

enum RepoApi: TargetType{
    case searchRepos(query: String, sort: String, order: String = "desc", perPage: Int = 30, page: Int = 1)
    
    var baseURL: URL{
        .init(string: Bundle.main.object(forInfoDictionaryKey: "GITHUB_BASE_URL") as! String)!
    }
    
    var path: String{
        switch self{
        case .searchRepos:
            return "search/repositories"
        }
    }
    
    var method: Moya.Method{
        switch self{
        case .searchRepos:
            return .get
        }
    }
    
    var task: Task{
        switch self{
        case let .searchRepos(query, sort, order, perPage, page):
            return .requestParameters(parameters: [
                "q": query,
                "sort": sort,
                "order": order,
                "per_page": perPage,
                "page": page
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .searchRepos:
            return nil
        }
    }
}
