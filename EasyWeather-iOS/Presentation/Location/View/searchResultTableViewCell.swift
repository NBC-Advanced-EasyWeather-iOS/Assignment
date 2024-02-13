//
//  searchResultTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/13/24.
//

import UIKit

class searchResultTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 16, bottom: 30, right: 16))
    }
    
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

// MARK: - Extensions : UI & Layout

extension searchResultTableViewCell {
    
    private func setUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}
