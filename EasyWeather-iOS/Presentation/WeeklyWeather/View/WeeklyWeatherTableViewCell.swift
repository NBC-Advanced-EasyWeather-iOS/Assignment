//
//  WeeklyTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import UIKit

class WeeklyTableViewCell: UITableViewCell {

    let dateLabel = UILabel()
    let weatherLabel = UILabel()
    let temperatureLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        // 라벨 설정
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(temperatureLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
}

