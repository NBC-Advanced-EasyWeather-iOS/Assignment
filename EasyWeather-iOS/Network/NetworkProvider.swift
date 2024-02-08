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
    
    func request(_ endpoint: T) async throws -> Data {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: 0)
        }
        
        return data
    }
}
