//
//  SessionManager.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol SessionManager {
    func execute(_ request: Requestable) async throws -> Data
}

class DefaultSessionManager: SessionManager {

    let configuration: URLSessionConfiguration

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
    }

    func execute(_ request: Requestable) async throws -> Data {
        guard let url = URL(string: request.URL) else {
            throw NetworkError.malformedURL
        }
        var urlRequest = URLRequest(url: url.withQueries(request.data))
        urlRequest.httpMethod = request.method.description
        let session = URLSession(configuration: configuration)
        var data: Data = Data()
        var response: URLResponse?
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            throw self.resolve(error)
        }
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard 200...299 ~= response.statusCode else {
            throw NetworkError.unacceptedCode(status: response.statusCode,
                                              response: response,
                                              data: data)
        }
        return data
    }

    private func resolve(_ error: Error) -> NetworkError {
        let errorCode = URLError.Code(rawValue: (error as NSError).code)
        switch errorCode {
        case .notConnectedToInternet:
            return .notConnectedToInternet
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
