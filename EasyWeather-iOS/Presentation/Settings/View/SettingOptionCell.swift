
//  SettingOptionView.swift
//  EasyWeather-iOS


import UIKit

// MARK: - Custom UICollectionViewCell

final class SettingOptionCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let identifier = "SettingOptionCell"
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension SettingOptionCell {
    
    private func setupLayout() {
        addSubview(checkImageView)
        addSubview(titleLabel)
        
        checkImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(24) //
            make.height.equalTo(24) // settingOptionCell 55,56 코드 변경 진행
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }

    }
    
    func configure(with option: SettingOptionModel) {
        titleLabel.text = option.title
        updateAppearance(isOn: option.isOn)
    }
    
    func updateAppearance(isOn: Bool) {
        self.titleLabel.textColor = isOn ? .primaryLabel : .tertiaryLabel
        self.backgroundColor = isOn ? .primaryBackground : .tertiaryBackground
        checkImageView.image = isOn ? UIImage(named: "Check") : UIImage(named: "UnCheck")
        
        SettingOptionUserDefault.shared.saveOptionsToUserDefaults(title: titleLabel.text!, isOn: isOn)
    }
    
    private func setupBorder() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.darkTheme.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
    }
}
