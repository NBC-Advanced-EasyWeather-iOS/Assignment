//
//  addedCityListTableViewCell.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/12/24.
//

import UIKit

final class addedCityListTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.textColor = UIColor.primaryLabel
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = FontLiteral.body(style: .regular)
        label.textColor = UIColor.primaryLabel
        
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.5, left: 0, bottom: 7.5, right: 0))
    }
}

// MARK: - Extensions : cell setup 메서드

extension addedCityListTableViewCell {
    
    func setCell(indexPath: IndexPath) {
        
        //데이터 연결
        guard let citys = CityList.shared.addedCity else { return }
        nameLabel.text = citys[indexPath.row]
        
        //네트워크 요청
        Task{
            let dailyResponse = try? await WeatherService().fetchCurrnetWeather(city: citys[indexPath.row])
            if let temp = dailyResponse?.main.temp {
                if let celsiusTemp = String(temp).kelvinToCelsius() {
                    temperatureLabel.text = celsiusTemp + "℃"
                }
            }
        }
    }
}

// MARK: - Extensions : UI & Layout

extension addedCityListTableViewCell {
    
    private func setUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = UIColor(hex: "CEDCF6")
        contentView.layer.cornerRadius = 20
        
        self.addSubview(nameLabel)
        self.addSubview(temperatureLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(27.5)
            make.bottom.equalToSuperview().offset(-27.5)
        }
        temperatureLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-28)
            make.top.equalToSuperview().offset(27.5)
            make.bottom.equalToSuperview().offset(-27.5)
        }
    }
}
