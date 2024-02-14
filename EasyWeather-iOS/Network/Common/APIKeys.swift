//
//  APIKeys.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/09.
//

import Foundation

struct APIKeys {
    static let openWeatherKey = ProcessInfo.processInfo.environment["APP_KEY"] ?? ""
}
