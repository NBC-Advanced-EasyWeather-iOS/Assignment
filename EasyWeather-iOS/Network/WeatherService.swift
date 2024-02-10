//
//  WeatherService.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/09.
//

import Foundation

final class WeatherService {
    private let provider: NetworkProviding
    
    init(provider: NetworkProviding = NetworkProvider()) {
        self.provider = provider
    }
}

extension WeatherService {
    func fetchCurrnetWeather(city: String) async throws -> DailyResponseDTO {
        let response: DailyResponseDTO = try await fetchData(.currentWeather(city: city))
        return response
    }
    
    func fetchWeeklyWeather(city: String) async throws -> WeeklyResponseDTO {
        let response: WeeklyResponseDTO = try await fetchData(.weeklyWeather(city: city))
        return response
    }
    
    private func fetchData<T: Decodable>(_ endPoint: WeatherEndpoint) async throws -> T {
        let data = try await provider.request(endPoint)
        let response = try JSONDecoder.snakeCaseDecoder.decode(T.self, from: data)
        return response
    }
}
