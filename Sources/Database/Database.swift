//
//  Database.swift
//  PerfectCURD
//
//  Created by Alif on 13/05/2018.
//

import Foundation
import PerfectPostgreSQL
import PerfectCRUD

//public struct Database<C: DatabaseConfigurationProtocol>: DatabaseProtocol {
//    public typealias Configuration = C
//    public let configuration: Configuration
//    public init(configuration c: Configuration)
//    public func table<T: Codable>(_ form: T.Type) -> Table<T, Database<C>>
//    public func transaction<T>(_ body: () throws -> T) throws -> T
//    public func create<A: Codable>(_ type: A.Type,
//                                   primaryKey: PartialKeyPath<A>? = nil,
//                                   policy: TableCreatePolicy = .defaultPolicy) throws -> Create<A, Self>
//}
