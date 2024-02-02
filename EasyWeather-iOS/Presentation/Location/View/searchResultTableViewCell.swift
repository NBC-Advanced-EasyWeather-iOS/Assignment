//
//  searchResultTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/13/24.
//

import UIKit

final class searchResultTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    lazy var resultLabel: UILabel = {
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - Extensions : cell setup 메서드

extension searchResultTableViewCell {
    
    func setCell() {
        self.resultLabel.text = "대한민국 부산광역시"
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
    
    //레이아웃 inset 메서드
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0))
    }
}
