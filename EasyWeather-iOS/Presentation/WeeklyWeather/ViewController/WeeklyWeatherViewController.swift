//
//  WeeklyViewController.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import UIKit

// MARK: - WeeklyWeatherViewController

final class WeeklyWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    let rootView = WeeklyWeatherView()
    var weatherService = WeatherService()
    private var weatherDataModel: [WeatherDataModel]?
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeeklyWeatherData()
        setupTableView()
    }
}

// MARK: - UITableViewDataSource
extension WeeklyWeatherViewController: UITableViewDataSource {
    
    private func setupTableView() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: WeeklyTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate

extension WeeklyWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyTableViewCell.identifier, for: indexPath) as? WeeklyTableViewCell else {
            return UITableViewCell()
        }
        
        if let model = weatherDataModel?[indexPath.row] {
            cell.configure(with: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = tableView.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width: UIScreen.screenWidth - 40, height: 25))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textColor = UIColor.black
        headerLabel.text = "이번주 날씨"
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

// MARK: - Network

extension WeeklyWeatherViewController {
    private func loadWeeklyWeatherData() {
        Task {
            let weeklyResponse = try await self.weatherService.fetchWeeklyWeather(city: "Seoul")
            
            var data = [String: WeatherDataModel]()
            let currentDate = Date()
            
            for list in weeklyResponse.list {
                let day = self.convertUnixTimeToDay(unixTime: list.dt)
                let weatherCondition = list.weather.first?.main ?? ""
                let temperature = String(list.main.temp)
                let model = WeatherDataModel(dayOfWeek: day, weatherCondition: weatherCondition, temperature: temperature, dt: list.dt)
                
                if let existingModel = data[day] {
                    let existingDate = Date(timeIntervalSince1970: TimeInterval(existingModel.dt))
                    let newDate = Date(timeIntervalSince1970: TimeInterval(model.dt))
                    if abs(newDate.timeIntervalSince(currentDate)) < abs(existingDate.timeIntervalSince(currentDate)) {
                        data[day] = model
                    }
                } else {
                    data[day] = model
                }
            }
            
            self.weatherDataModel = Array(data.values).sorted { $0.dt < $1.dt }
            
            DispatchQueue.main.async {
                self.rootView.tableView.reloadData()
            }
        }
    }
}

extension WeeklyWeatherViewController {
    private func convertUnixTimeToDay(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
