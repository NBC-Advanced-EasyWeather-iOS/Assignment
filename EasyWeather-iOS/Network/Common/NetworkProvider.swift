//
//  NetworkProvider.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

/**
 request 메서드 호출 예시
 
 let provider = NetworkProvider<WeatherEndpoint>()
 async {
     do {
         let data = try await provider.request(.currentWeather(city: "Seoul"))
         // 데이터 처리 코드
     } catch {
         // 에러 처리 코드
     }
 }
 */

import Foundation

final class NetworkProvider<T: EndpointType> {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkProvider {
    func request(_ endpoint: T) async throws -> Data {
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
    
    private func makeURL(from endpoint: T) throws -> URL {
        var components = URLComponents(url: endpoint.baseURL, resolvingAgainstBaseURL: true)
        components?.path = endpoint.path
        components?.query = endpoint.query
        
        guard let url = components?.url else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL 생성 실패"])
        }
        
        return url
    }
    
    private func makeRequest(with url: URL, endpoint: T) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = endpoint.headers
        
        return request
    }
}
