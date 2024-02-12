//
//  addedCityListTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/12/24.
//

import UIKit

class addedCityListTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.textColor = .black
        
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.backgroundColor = UIColor(hex: "CEDCF6")
//        self.layer.cornerRadius = 20
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

extension addedCityListTableViewCell {
    
    private func setUI() {
        
        self.addSubview(nameLabel)
        self.addSubview(temperatureLabel)
        
        self.backgroundColor = UIColor(hex: "CEDCF6")
        self.layer.cornerRadius = 20
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
        }
//        
        temperatureLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView).offset(-28)
        }
    }
}
