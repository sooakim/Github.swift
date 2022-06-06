//
//  MoyaProviderType+Concurrency.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Moya

extension MoyaProvider: ConcurrencyCompatible {}

extension Concurrency where Base: MoyaProviderType{
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) async throws -> Response{
        var cancellable: Cancellable? = nil
        let cancel = {
            if let cancellable = cancellable, !cancellable.isCancelled {
                cancellable.cancel()
            }
        }
        
        return try await withTaskCancellationHandler{
            cancel()
        } operation: {
            try await withUnsafeThrowingContinuation{ [weak base] (continutation: UnsafeContinuation<Response, Error>) in
                cancellable = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                    switch result{
                    case let .success(response):
                        continutation.resume(returning: response)
                    case let .failure(error):
                        continutation.resume(throwing: error)
                    }
                }
            }
        }
    }
        
    func requestWithDecode<T>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) async throws -> T where T: Decodable{
        let response = try await request(token, callbackQueue: callbackQueue)
        print(String(data: response.data, encoding: .utf8))
        return try response.map(T.self)
    }
}
