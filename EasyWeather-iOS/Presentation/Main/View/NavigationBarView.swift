//
//  NavigationBarView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/7/24.
//

import UIKit

final class NavigationBarView: UIView {
    
    // MARK: - UI Properties
    
    private lazy var countryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("대한민국", for: .normal)
        button.titleLabel?.font = FontLiteral.body(style: .regular)
        button.tintColor = .primaryLabel
        button.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
        
        let image = UIImage(named: "LocationArrow")
        button.setImage(image, for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()

    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "수원시"
        label.font = FontLiteral.title3(style: .bold)
        
        return label
    }()
    
    private lazy var navigationLeftLocationInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryButton, cityLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var settingMenuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "SettingMenu")
        
        button.setImage(image, for: .normal)
        button.tintColor = .primaryLabel
        
        return button
    }()
    
    lazy var locationPlusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "LocationPlus")
        
        button.setImage(image, for: .normal)
        button.tintColor = .primaryLabel
        
        return button
    }()
    
    private lazy var navigationRightButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingMenuButton, locationPlusButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
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

// MARK: - Extensions

extension NavigationBarView {
    private func setUI() {
        self.backgroundColor = .clear
        
        [navigationLeftLocationInfoStackView, navigationRightButtonsStackView].forEach {
            self.addSubview($0)
        }
    }

    private func setLayout() {
        navigationLeftLocationInfoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        navigationRightButtonsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(10)
        }
    }
}
