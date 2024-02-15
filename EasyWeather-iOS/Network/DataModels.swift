//
//  DataModels.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/08.
//

// MARK: - Models

struct WeatherResponseType {
    let cityName: String
    let main: Main
    let sys: Sys
}

struct WeatherDTO {
    let cityName: String
    let temperature: String
    let condition: String
    let dateString: String // 요일 정보를 포함시키는 속성 추가
}

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
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
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

