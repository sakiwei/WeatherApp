//
//  APIClient.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol APIClient: AnyObject {
    var sessionManager: SessionManager { get }
    func execute(_ request: Requestable) async throws -> Data
    func getObject<T: Decodable>(_ request: Requestable) async throws -> T
}

class DefaultAPIClient: APIClient {
    public let sessionManager: SessionManager

    func execute(_ request: Requestable) async throws -> Data {
        return try await self.sessionManager.execute(request)
    }

    func getObject<T: Decodable>(_ request: Requestable) async throws -> T {
        let data = try await self.sessionManager.execute(request)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func getList<T: Decodable>(_ request: Requestable) async throws -> [T] {
        let data = try await self.sessionManager.execute(request)
        return try JSONDecoder().decode([T].self, from: data)
    }

    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
}
