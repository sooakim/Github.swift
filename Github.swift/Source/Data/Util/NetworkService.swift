//
//  NetworkService.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Moya

class NetworkService{
    static let shared: NetworkService = .init()
    
    let repoApi: MoyaProvider<RepoApi>
    
    private init(){
        let plugins: [PluginType] = [
            NetworkLoggerPlugin()
        ]
        
        self.repoApi = .init(callbackQueue: DispatchQueue.main, plugins: plugins)
    }
}
