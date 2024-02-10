//
//  NetworkProvider.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import Foundation

protocol NetworkProviding {
    func request(_ endpoint: WeatherEndpoint) async throws -> Data
}

final class NetworkProvider: NetworkProviding {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkProvider {
    func request(_ endpoint: WeatherEndpoint) async throws -> Data {
        let url = try makeURL(from: endpoint)
        var request = makeRequest(with: url, endpoint: endpoint)
        
        NetworkLogger.log(request: request)
        
        let (data, response) = try await session.data(for: request)
        
        NetworkLogger.log(response: response, data: data, error: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: 0)
        }
        
        return data
    }
    
    private func makeURL(from endpoint: WeatherEndpoint) throws -> URL {
        var components = URLComponents(url: endpoint.baseURL, resolvingAgainstBaseURL: true)
        components?.path = endpoint.path
        components?.query = endpoint.query
        
        guard let url = components?.url else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL 생성 실패"])
        }
        
        return url
    }
    
    private func makeRequest(with url: URL, endpoint: WeatherEndpoint) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = endpoint.headers
        
        return request
    }
}
