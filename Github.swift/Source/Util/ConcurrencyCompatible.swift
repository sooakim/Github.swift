//
//  ConcurrencyCompatible.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import Moya

struct Concurrency<Base>{
    let base: Base
    
    init(_ base: Base){
        self.base = base
    }
}

protocol ConcurrencyCompatible{
    associatedtype ConcurrencyBase
    
    static var concurrency: Concurrency<ConcurrencyBase>.Type { get }
    
    var concurrency: Concurrency<ConcurrencyBase>{ get }
}

extension ConcurrencyCompatible{
    static var concurrency: Concurrency<Self>.Type{
        return Concurrency<Self>.self
    }
    
    var concurrency: Concurrency<Self>{
        return Concurrency(self)
    }
}
