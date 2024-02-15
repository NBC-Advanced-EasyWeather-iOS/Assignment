//
//  Date+Extension.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/16/24.
//

import Foundation

extension Date {
    func sunriseAndSunsetStringFromUnixTime(sunriseUnixTime: TimeInterval, sunsetUnixTime: TimeInterval) -> (String, String) {
        
        let sunriseDate = Date(timeIntervalSince1970: sunriseUnixTime)
        let sunsetDate = Date(timeIntervalSince1970: sunsetUnixTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        
        let formattedSunrise = dateFormatter.string(from: sunriseDate)
        let formattedSunset = dateFormatter.string(from: sunsetDate)
        
        return (formattedSunrise, formattedSunset)
    }
}
