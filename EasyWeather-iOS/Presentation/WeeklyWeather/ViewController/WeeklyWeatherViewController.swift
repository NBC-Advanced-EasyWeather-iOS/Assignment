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
    
    private var weatherDataModel: [WeatherDataModel]?
    private let weatherService: WeatherService?
    
    // MARK: - UI Properties
    
    private let rootView: WeeklyWeatherView?
    
    // MARK: - Life Cycle
    
    init(weatherService: WeatherService = WeatherService(), rootView: WeeklyWeatherView = WeeklyWeatherView()) {
        self.weatherService = weatherService
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension WeeklyWeatherViewController: UITableViewDataSource {}

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
            let weeklyResponse = try await self.weatherService?.fetchWeeklyWeather(city: "Seoul")
            
            var data = [String: WeatherDataModel]()
            
            guard let listArray = weeklyResponse?.list else { return }
            
            for i in listArray {
                let day = self.convertUnixTimeToDay(unixTime: i.dt)
                let weatherCondition = i.weather.first?.main ?? ""
                let temperature = String(i.main.temp)
                let model = WeatherDataModel(dayOfWeek: day, weatherCondition: weatherCondition, temperature: temperature, dt: i.dt)
                
                data[day] = self.findClosestData(existingModel: data[day], newModel: model)
            }
            
            self.weatherDataModel = Array(data.values).sorted { $0.dt < $1.dt }
            
            DispatchQueue.main.async {
                self.rootView?.tableView.reloadData()
            }
        }
    }
}

extension WeeklyWeatherViewController {
    
    // MARK: - Setups
    
    private func setupTableView() {
        rootView?.tableView.dataSource = self
        rootView?.tableView.delegate = self
        rootView?.tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: WeeklyTableViewCell.identifier)
    }
    
    // MARK: - General Helpers
    
    private func findClosestData(existingModel: WeatherDataModel?, newModel: WeatherDataModel) -> WeatherDataModel {
        let currentDate = Date()
        
        if let existingModel = existingModel {
            let existingDate = Date(timeIntervalSince1970: TimeInterval(existingModel.dt))
            let newDate = Date(timeIntervalSince1970: TimeInterval(newModel.dt))
            
            return abs(newDate.timeIntervalSince(currentDate)) < abs(existingDate.timeIntervalSince(currentDate)) ? newModel : existingModel
        } else {
            return newModel
        }
    }
    
    private func convertUnixTimeToDay(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
