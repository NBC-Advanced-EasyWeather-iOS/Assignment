//
//  WeatherEndpoint.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import Foundation

enum WeatherEndpoint: EndpointType {
    case currentWeather(city: String)
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org") else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeather(let city):
            return "/data/2.5/weather?q=\(city)"
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
