//
//  MeteorologicalCollectionViewCell.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/9/24.
//

import UIKit

class MeteorologicalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MeteorologicalCollectionViewCellIdentifier"
    
    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        
        return label
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

// MARK: - Extensions : UI & Layout

extension MeteorologicalCollectionViewCell {
    private func setUI() {
        backgroundColor = .blue
        
        [titleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Configure Cell

extension MeteorologicalCollectionViewCell {
    func configure(withText text: String) {
        self.titleLabel.text = text
    }
}
