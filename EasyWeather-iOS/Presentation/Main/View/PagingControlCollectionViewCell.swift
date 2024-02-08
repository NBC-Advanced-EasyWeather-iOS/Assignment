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
    
    // MARK: - UI Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .mainTheme
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
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

extension PagingControlCollectionViewCell {
    private func setUI() {
        self.backgroundColor = .secondaryBackground
        
        [label].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
        }
    }
}

// MARK: - Configure Cell

extension PagingControlCollectionViewCell {
    
    func configure(withText text: String) {
        label.text = text
    }
}
