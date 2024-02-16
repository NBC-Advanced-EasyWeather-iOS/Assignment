//
//  String+Extension.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

extension String {
    
    // 켈빈 -> 섭씨
    func kelvinToCelsius() -> String? {
        guard let kelvin = Double(self) else { return nil }
        let celsius = kelvin - 273.15
        return String(format: "%.0f°C", celsius)
    }
    
    // 섭씨 -> 화씨
    func celsiusToFahrenheit() -> String? {
        guard let celsius = Double(self) else { return nil }
        let fahrenheit = (celsius * 9/5) + 32
        return String(format: "%.0f", fahrenheit)
    }
    
    // 화씨 -> 섭씨
    func fahrenheitToCelsius() -> String? {
        guard let fahrenheit = Double(self) else { return nil }
        let celsius = (fahrenheit - 32) * 5/9
        return String(format: "%.0f", celsius)
    }
}
