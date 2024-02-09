//
//  EndpointType.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var query: String? { get }
    var headers: [String: String]? { get }
}
