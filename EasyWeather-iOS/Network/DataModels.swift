//
//  DataModels.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/08.
//

// MARK: - Models

struct DailyResponseDTO: Codable {
    let weather: [Weather]
    let main: Main
    let rain: Rain?
    let sys: Sys
    let name: String
}

struct WeeklyResponseDTO: Codable {
    let city: City
    let list: [List]
}

// MARK: - Common

struct Weather: Codable {
    let main: String
}

// MARK: - DailyResponseDTO

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

struct Rain: Codable {
    let oneHour: Float?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct Sys: Codable {
    let country: String
    let sunrise: Double
    let sunset: Double
}

// MARK: - WeeklyResponseDTO

struct City: Codable {
    let name: String
}

struct List: Codable {
    let dt: Int
    let temp: Temp
    let weather: Weather
}

struct Temp: Codable {
    let day: Float
}

