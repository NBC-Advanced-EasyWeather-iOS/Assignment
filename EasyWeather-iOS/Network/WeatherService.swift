//
//  WeatherService.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/09.
//

import Foundation

final class WeatherService {
    private let provider = NetworkProvider<WeatherEndpoint>()
    
    func fetchCurrnetWeather(city: String) async throws -> DailyResponseDTO {
        let data = try await provider.request(.currentWeather(city: city))
        
        let weatherResponse = try JSONDecoder.snakeCaseDecoder.decode(DailyResponseDTO.self, from: data)
        return weatherResponse
    }
    
    func fetchWeeklyWeather(city: String) async throws -> WeeklyResponseDTO {
        let data = try await provider.request(.weeklyWeather(city: city))
        
        let weatherResponse = try JSONDecoder.snakeCaseDecoder.decode(WeeklyResponseDTO.self, from: data)
        return weatherResponse
    }
}
