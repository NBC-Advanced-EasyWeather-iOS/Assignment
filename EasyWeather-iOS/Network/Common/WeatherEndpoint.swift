//
//  WeatherEndpoint.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import Foundation

enum WeatherEndpoint: EndpointType {
    case currentWeather(city: String)
    case weeklyWeather(city: String)
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org") else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        case .weeklyWeather:
            return "/data/2.5/forecast/daily"
        }
    }
    
    var query: String? {
        switch self {
        case .currentWeather(let city):
            return "q=\(city)&appid=\(APIKeys.openWeatherKey)"
        case .weeklyWeather(let city):
            return "q=\(city)&appid=\(APIKeys.openWeatherKey)"
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
