
import Foundation

// MARK: - SettingOption Model

class SettingOptionModel {
    let title: String
    var isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}

class SettingOptionUserDefault {
    static let shared = SettingOptionUserDefault()
    
    private init() {}
    
    let optionKeys: [String] = [
        "일출/일몰 시간",
        "최저/최고 기온",
        "기압",
        "습도",
        "섭씨온도 °C",
        "화씨온도 °F"
    ]
    
    let settingOptions: [String] = ["일출","일몰","최저 기온","최고 기온","기압","습도"]
    var settingOptionsData: [SettingOptionModel] = []
    
    func loadOptionsFromUserDefaults() -> [SettingOptionModel] {
        settingOptionsData = []
        optionKeys.forEach { option in
            if let value = UserDefaults.standard.string(forKey: option) {
                let boolValue = value == "1"
                settingOptionsData.append(SettingOptionModel(title: option, isOn: boolValue))
            }
        }
        return settingOptionsData
    }
}

