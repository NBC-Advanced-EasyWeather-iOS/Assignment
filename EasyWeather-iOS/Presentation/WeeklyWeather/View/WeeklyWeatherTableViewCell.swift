//
//  WeeklyTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import UIKit

final class WeeklyTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "WeeklyTableViewCell"
    
    // MARK: - UI Properties
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.text = "월요일"
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .bold)
        label.text = "소나기"
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.largeTitle(style: .bold)
        label.text = "10.C"
        return label
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Extensions

extension WeeklyTableViewCell {
    
    // MARK: - Layout
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configure(with model: WeatherDataModel) {
        dateLabel.text = model.dayOfWeek
        weatherLabel.text = model.weatherCondition
        temperatureLabel.text = model.temperature
    }
}
