//
//  NetworkProvider.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import Foundation

final class NetworkProvider<T: EndpointType> {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ endpoint: T) async throws Data {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.httpMethod
    }
}
