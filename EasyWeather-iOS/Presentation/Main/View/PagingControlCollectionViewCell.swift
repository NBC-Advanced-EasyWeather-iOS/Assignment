//
//  PagingControlCollectionViewCell.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/8/24.
//

import UIKit

class PagingControlCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PagingControlCollectionViewCellIdentifier"
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
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
    
    private lazy var weatherStackView: UIStackView = { createWeatherStackView() }()
    
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
            make.top.equalToSuperview().offset(screenHeight * iconTopOffsetRatio)
            make.width.equalToSuperview().multipliedBy(iconWidthRatio)
            make.height.equalToSuperview().multipliedBy(iconHeightRatio)
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(screenHeight * stackViewTopOffsetRatio)
        }
        
        weekendWeatherButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherStackView.snp.bottom).offset(screenHeight * buttonTopOffsetRatio)
        }
        
        meteorologicalCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(screenWidth * collectionViewLeadingOffsetRatio)
            make.trailing.equalToSuperview().offset(-screenWidth * collectionViewTrailingOffsetRatio)
            make.bottom.equalToSuperview().offset(-screenHeight * collectionViewBottomOffsetRatio)
            make.height.equalToSuperview().multipliedBy(collectionViewHeightRatio)
        }
    }

    private func createWeatherLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = .primaryLabel
        
        return label
    }
    
    private func createWeatherStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel, windChillGuideLabel, windChillLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }
}

// MARK: - Configure Cell

extension PagingControlCollectionViewCell {
    
    func configure(withText text: String) {
        weatherIcon.image = UIImage(named: "Weather/DayPartlyCloudy")
        temperatureLabel.text = "\(text)°C"
        windChillGuideLabel.text = "어제보다 \(text)도 높아요 😊"
        windChillLabel.text = "체감온도 \(text)℃"
    }
}
