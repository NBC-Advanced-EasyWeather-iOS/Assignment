//
//  PagingControlCollectionViewCell.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/8/24.
//

import UIKit

import SnapKit

class PagingControlCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PagingControlCollectionViewCellIdentifier"
    private let screenHeight = UIScreen.main.bounds.height // 런타임 시에 변경될 가능성이 거의 없으므로 선언 시점에 즉시 값을 할당
    
    // MARK: - UI Properties
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "DayPartlyCloudy")
        
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
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel, windChillGuideLabel, windChillLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var weekendWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주간 날씨", for: .normal)
        button.titleLabel?.font = FontLiteral.body(style: .bold)
        button.tintColor = .mainTheme
        
        let image = UIImage(named: "NextWeekendArrow")
        button.setImage(image, for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
    
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
        
        [weatherIcon, weatherStackView, weekendWeatherButton, meteorologicalCollectionView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(screenHeight * 0.03)
        }
        
        weekendWeatherButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherStackView.snp.bottom).offset(screenHeight * 0.04)
        }
        
        meteorologicalCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.35)
        }
    }

    private func createWeatherLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = .primaryLabel
        
        return label
    }
}

// MARK: - Configure Cell

extension PagingControlCollectionViewCell {
    
    func configure(withText text: String) {
        temperatureLabel.text = "\(text)°C"
        windChillGuideLabel.text = "어제보다 \(text)도 높아요 😊"
        windChillLabel.text = "체감온도 \(text)℃"
    }
}
