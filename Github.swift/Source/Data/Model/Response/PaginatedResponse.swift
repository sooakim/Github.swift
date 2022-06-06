//
//  PaginatedResponse.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation

struct PaginatedResponse<Item: Decodable>: Decodable{
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
    
    enum CodingKeys: String, CodingKey{
    case totalCount = "total_count"
    case incompleteResults = "incomplete_results"
    case items
    }
}
