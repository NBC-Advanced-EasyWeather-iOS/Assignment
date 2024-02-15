//
//  WeeklyView.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import UIKit

import SnapKit

class WeeklyWeatherView: UIView {
    let stackView = UIStackView()
    let leftSpacerView = UIView()
    let weeklyWeatherImageView = UIImageView()
    let tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = UIColor.lightTheme
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        stackView.addArrangedSubview(leftSpacerView)
        stackView.addArrangedSubview(weeklyWeatherImageView)
        
        weeklyWeatherImageView.contentMode = .scaleAspectFit
        weeklyWeatherImageView.clipsToBounds = true
        
        if let image = UIImage(named: "DayCloud") {
            weeklyWeatherImageView.image = image
        } else {
            // 이미지를 찾을 수 없을 경우의 처리
            weeklyWeatherImageView.backgroundColor = UIColor.lightTheme
        }
        
        // 테이블 뷰 설정
        tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        
        // SnapKit을 사용하여 오토레이아웃 설정
        leftSpacerView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
        }
        
        weeklyWeatherImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview() // 우측 하단에 붙임

        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(weeklyWeatherImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

