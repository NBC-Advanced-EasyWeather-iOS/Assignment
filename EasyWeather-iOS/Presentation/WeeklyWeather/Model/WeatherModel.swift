//
//  WeatherModel.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import Foundation

struct Weather {
    let dayOfWeek: String
    let weatherCondition: String
    let temperature: String
}

class WeatherData {
    static let shared = WeatherData()
    
    private init() {}
    
    let daysOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    let weathers = ["Sunny", "Cloudy", "Rainy", "Snowy", "Windy", "Foggy", "Thunderstorms"]
    let temperatures = ["20°C", "18°C", "22°C", "17°C", "19°C", "21°C", "23°C"]
    
    func getWeatherData() -> [Weather] {
        var weatherData = [Weather]()
        
        for index in 0..<daysOfWeek.count {
            let weather = Weather(dayOfWeek: daysOfWeek[index], weatherCondition: weathers[index], temperature: temperatures[index])
            weatherData.append(weather)
        }
        
        return weatherData
    }
}
