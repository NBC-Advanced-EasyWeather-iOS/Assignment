//
//  DataModels.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/08.
//

// MARK: - Models

struct WeatherViewModel {
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
    let list: [DayWeather] // `list`를 `City`와 같은 수준으로 이동

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
    let id: Int
    let coord: Coordinates
    let country: String
    let population: Int
    let timezone: Int
}

struct Coordinates: Codable {
    let lon: Float
    let lat: Float
}



struct DayWeather: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
    
    struct List: Codable {
        let temp: Temp
        let weather: Weather
    }
    
    struct Temp: Codable {
        let day: Float
    }
    
}
