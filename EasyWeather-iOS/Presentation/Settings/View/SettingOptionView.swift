
//  SettingOptionView.swift
//  EasyWeather-iOS


import UIKit

// MARK: - Custom UICollectionViewCell

class SettingOptionCell: UICollectionViewCell {
    
    static let identifier = "SettingOptionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(checkImageView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor, constant: -10),
            
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            checkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with option: SettingOption) {
        titleLabel.text = option.title
        updateAppearance(isOn: option.isOn)
    }
    
    func updateAppearance(isOn: Bool) {
        self.backgroundColor = isOn ? .primaryBackground : .secondaryBackground // 화이트 색상과 F2F2F7 색상 적용
        checkImageView.image = isOn ? UIImage(named: "checkedImage") : UIImage(named: "uncheckedImage")
    }
    
    
    private func setupBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.darkTheme.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
