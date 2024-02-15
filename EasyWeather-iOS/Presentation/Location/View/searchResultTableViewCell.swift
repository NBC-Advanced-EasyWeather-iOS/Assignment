//
//  searchResultTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/13/24.
//

import UIKit

final class searchResultTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.textColor = .black
        
        return label
    }()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //레이아웃 inset 메서드
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0))
    }
}

// MARK: - Extensions : cell setup 메서드

extension searchResultTableViewCell {
    
    func setCell(indexPath: IndexPath) {
        
        //바인딩
        guard let citys = CityList.shared.searchedCity else { return }
        
        resultLabel.text = citys[indexPath.row]
    }
}

// MARK: - Extensions : UI & Layout

extension searchResultTableViewCell {
    
    private func setUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview()
        }
    }
}
