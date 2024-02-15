//
//  String+Extension.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

extension String {
    
    func kelvinToCelsius() -> String? {
        guard let kelvin = Double(self) else { return nil }
        let celsius = kelvin - 273.15
        return String(format: "%.0f", celsius)
    }
    
    func celsiusToKelvin() -> String? {
        guard let celsius = Double(self) else { return nil }
        let kelvin = celsius + 273.15
        return String(format: "%.0f", kelvin)
    }
}
