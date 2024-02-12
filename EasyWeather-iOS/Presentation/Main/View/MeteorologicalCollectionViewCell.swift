//
//  MeteorologicalCollectionViewCell.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/9/24.
//

import UIKit

final class MeteorologicalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MeteorologicalCollectionViewCellIdentifier"
    
    private var iconImageWidthHeightRatio: CGFloat = 0
    
    // MARK: - UI Properties
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryLabel
        label.font = FontLiteral.subheadline(style: .regular)
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryLabel
        label.font = FontLiteral.title3(style: .bold)
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = { createLabelStackView() }()
    private lazy var cellStackView: UIStackView = { createCellStackView() }()
    
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

extension MeteorologicalCollectionViewCell {
    private func setUI() {
        backgroundColor = .clear
        iconImageWidthHeightRatio = contentView.frame.size.height * 0.7
        
        self.addSubview(cellStackView)
    }
    
    private func setLayout() {
        cellStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(iconImageWidthHeightRatio)
            make.height.equalTo(iconImageWidthHeightRatio)
        }
    }
    
    private func createLabelStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        
        return stackView
    }
    
    private func createCellStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [iconImage, labelStackView])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .leading
        
        return stackView
    }
}

// MARK: - Configure Cell

extension MeteorologicalCollectionViewCell {
    func configure(withText text: String, type: String) {
        self.titleLabel.text = text
        self.contentLabel.text = "1030 hPa"
        self.iconImage.isHidden = false
        
        if type == "일출" {
            self.iconImage.image = UIImage(named: "Weather/Sunrise")
        } else if type == "일몰" {
            self.iconImage.image = UIImage(named: "Weather/Sunset")
        } else {
            self.iconImage.image = nil
            self.iconImage.isHidden = true
        }
    }
}
