//
//  Request.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
// MARK: - Request Method

enum RequestMethod {
    case GET
    // TODO: support POST method in future
}

extension RequestMethod: CustomStringConvertible {
    public var description: String {
        switch self {
        case .GET:
            return "GET"
        }
    }
}

// MARK: - Request

protocol Requestable {
    var method: RequestMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var data: [String: String] { get }
}

// MARK: - Endpoint

extension Requestable {
    var URL: String {
        return self.baseURL + self.path
    }
}
