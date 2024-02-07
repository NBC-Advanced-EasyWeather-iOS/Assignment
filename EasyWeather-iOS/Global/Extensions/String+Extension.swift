//
//  String+Extension.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

extension String {
    
  // 섭씨 -> 화씨
  func celsiusToFahrenheit() -> String? {
    guard let celsius = Double(self) else { return nil }
    let fahrenheit = (celsius * 9/5) + 32
    return String(format: "%.2f", fahrenheit) // 소수점 2자리
  }
    
  // 화씨 -> 섭씨
  func fahrenheitToCelsius() -> String? {
    guard let fahrenheit = Double(self) else { return nil }
    let celsius = (fahrenheit - 32) * 5/9
    return String(format: "%.2f", celsius) // 소수점 2자리
  }
}
