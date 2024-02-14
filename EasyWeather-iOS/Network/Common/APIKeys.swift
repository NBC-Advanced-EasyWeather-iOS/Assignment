//
//  APIKeys.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/09.
//

import Foundation

struct APIKeys {
    static var openWeatherKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String ?? ""
    }
}
