//
//  PagingControlCollectionViewCell.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/8/24.
//

import UIKit

final class PagingControlCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PagingControlCollectionViewCellIdentifier"
    
    private var width: CGFloat = UIScreen.screenWidth
    private var height: CGFloat = UIScreen.screenHeight
    
    private let iconTopOffsetRatio: CGFloat = 0.0
    private let iconWidthRatio: CGFloat = 0.4
    private let iconHeightRatio: CGFloat = 0.25
    private let stackViewTopOffsetRatio: CGFloat = 0.03
    private let buttonTopOffsetRatio: CGFloat = 0.04
    private let collectionViewLeadingOffsetRatio: CGFloat = 0.05
    private let collectionViewTrailingOffsetRatio: CGFloat = 0.05
    private let collectionViewBottomOffsetRatio: CGFloat = 0.015
    private let collectionViewHeightRatio: CGFloat = 0.35
    
    // MARK: - UI Properties
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        return createWeatherLabel(font: FontLiteral.largeTitle(style: .bold))
    }()

    private lazy var windChillGuideLabel: UILabel = {
        return createWeatherLabel(font: FontLiteral.subheadline(style: .regular))
    }()
    
    private lazy var windChillLabel: UILabel = {
        return createWeatherLabel(font: FontLiteral.body(style: .bold))
    }()
    
    lazy var weekendWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주간 날씨", for: .normal)
        button.titleLabel?.font = FontLiteral.body(style: .bold)
        button.tintColor = .mainTheme
        
        let image = UIImage(named: "NextWeekendArrow")
        button.setImage(image, for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
    
    private lazy var weatherStackView: UIStackView = { createWeatherStackView() }()
    private lazy var meteorologicalCollectionView = MeteorologicalCollectionView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions : UI & Layout

extension PagingControlCollectionViewCell {
    private func setUI() {
        
        self.backgroundColor = .clear
        
        [ weatherIcon,
         weatherStackView,
         weekendWeatherButton,
         meteorologicalCollectionView ].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(height * iconTopOffsetRatio)
            make.width.equalToSuperview().multipliedBy(iconWidthRatio)
            make.height.equalToSuperview().multipliedBy(iconHeightRatio)
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(height * stackViewTopOffsetRatio)
        }
        
        weekendWeatherButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherStackView.snp.bottom).offset(height * buttonTopOffsetRatio)
        }
        
        meteorologicalCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(width * collectionViewLeadingOffsetRatio)
            make.trailing.equalToSuperview().offset(-width * collectionViewTrailingOffsetRatio)
            make.bottom.equalToSuperview().offset(-height * collectionViewBottomOffsetRatio)
            make.height.equalToSuperview().multipliedBy(collectionViewHeightRatio)
        }
    }

    private func createWeatherLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = .primaryLabel
        label.text = "-"
        
        return label
    }
    
    private func createWeatherStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel, windChillLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }
}

// MARK: - Configure Cell

extension PagingControlCollectionViewCell {
    func configure(weatherData: WeatherResponseType, settingData: [SettingOptionModel]) {
        meteorologicalCollectionView.weatherData = weatherData
        meteorologicalCollectionView.settingData = settingData
        
        selectWeatherImage(weatherData: weatherData)
//        if weatherData.weather.first?.main == "Clear" {
//            self.weatherIcon.image = UIImage(named: "Weather/DayPartlyCloudy")
//        }
//        Clear
//        Drizzle
//        Rain
//        Snow
//        Mist
//        Clouds
        
        let temp = String(Int(weatherData.main.temp)).kelvinToCelsius() ?? "N/A"
        let feel = String(Int(weatherData.main.feelsLike)).kelvinToCelsius() ?? "N/A"
        
        if settingData[4].isOn == true {
            self.temperatureLabel.text = "\(String(describing: temp))°C"
        } else {
            self.temperatureLabel.text = "\(String(describing: temp.celsiusToKelvin()!))°F"
        }
        
        self.windChillLabel.text = "체감온도 \(feel)°C"
    }
    
    func addTargetForWeekendWeatherButton(_ target: Any?, action: Selector) {
        weekendWeatherButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func selectWeatherImage(weatherData: WeatherResponseType) {
        guard let weatherMain = weatherData.weather.first?.main else {
            return
        }

        switch weatherMain {
        case "Clear":
            self.weatherIcon.image = UIImage(named: "Weather/Clear")
        case "Drizzle":
            self.weatherIcon.image = UIImage(named: "Weather/Drizzle")
        case "Rain":
            self.weatherIcon.image = UIImage(named: "Weather/Rain")
        case "Snow":
            self.weatherIcon.image = UIImage(named: "Weather/Snow")
        case "Clouds":
            self.weatherIcon.image = UIImage(named: "Weather/DayPartlyCloudy")
        default:
            if ["Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado"].contains(weatherMain) {
                self.weatherIcon.image = UIImage(named: "Weather/Wind")
            }
            break
        }
    }
}
