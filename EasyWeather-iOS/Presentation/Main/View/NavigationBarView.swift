//
//  NavigationBarView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/7/24.
//

import UIKit

class NavigationBarView: UIView {
    
    // MARK: - UI Properties
    
    private let countryButton: UIButton = {
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

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "수원시"
        label.font = FontLiteral.title3(style: .bold)
        
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryButton, cityLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        
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
        
        [locationStackView].forEach {
            self.addSubview($0)
        }
    }

    private func setLayout() {
        locationStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
