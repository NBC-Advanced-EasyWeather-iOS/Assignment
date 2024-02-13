
// MARK: - SettingOption Model

struct SettingOptionModel {
    let title: String
    var isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}
