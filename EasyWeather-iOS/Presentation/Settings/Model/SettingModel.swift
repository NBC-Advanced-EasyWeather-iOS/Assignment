
//  SettingModel.swift
//  EasyWeather-iOS


import Foundation

// MARK: - SettingOption Model

class SettingOption {
    let title: String
    var isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}


