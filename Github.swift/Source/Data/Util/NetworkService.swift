//
//  NetworkService.swift
//  Github.swift
//
//  Created by κΉμμ on 2022/06/06.
//

import Foundation
import Moya

final class NetworkService{
    static let shared: NetworkService = .init()
    
    let repoApi: MoyaProvider<RepoApi>
    
    private init(){
        let plugins: [PluginType] = [
            NetworkLoggerPlugin()
        ]
        
        self.repoApi = .init(callbackQueue: DispatchQueue.main, plugins: plugins)
    }
}
