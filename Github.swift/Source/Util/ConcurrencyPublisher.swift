//
//  ConcurrencyPublisher.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Combine

final class ConcurrencyPublisher<Value>: Publisher{
    typealias Output = Value
    typealias Failure = Error
    
    typealias Operation = () async throws -> Value
    
    private let taskPriority: TaskPriority?
    private let operation: Operation
    
    init(taskPriority: TaskPriority? = nil, operation: @escaping Operation){
        self.taskPriority = taskPriority
        self.operation = operation
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = _Subscription(taskPriority: taskPriority, operation: operation, downstream: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

extension ConcurrencyPublisher{
    final class _Subscription<Downstream: Subscriber>: Subscription where Downstream.Input == Output, Downstream.Failure == Failure{
        private var downstream: Downstream? = nil
        private var task: Task<Output, Failure>? = nil
        
        private let taskPriority: TaskPriority?
        private let operation: Operation
        
        init(taskPriority: TaskPriority?, operation: @escaping Operation, downstream: Downstream){
            self.taskPriority = taskPriority
            self.operation = operation
            self.downstream = downstream
        }
        
        func request(_ demand: Subscribers.Demand) {
            assert(demand > 0)
            guard self.downstream != nil else{ return }
            self.task = Task.detached(priority: taskPriority, operation: {
                do{
                    let result = try await self.operation()
                    _ = self.downstream?.receive(result)
                    self.downstream?.receive(completion: .finished)
                    return result
                }catch{
                    self.downstream?.receive(completion: .failure(error))
                    throw error
                }
            })
        }
        
        func cancel() {
            self.task?.cancel()
            self.task = nil
            self.downstream = nil
        }
    }
}
