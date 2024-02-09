//
//  JSONDecoder+Extension.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/09.
//

import Foundation

extension JSONDecoder {
    static var snakeCaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
