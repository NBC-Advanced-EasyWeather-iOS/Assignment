//
//  WeeklyViewController.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//
import UIKit

final class WeeklyWeatherViewController: UIViewController {
    
    // MARK: - Properties
    let myView = WeeklyWeatherView()
    var weatherService = WeatherService()
    var weatherViewModels: [WeatherDTO] = []
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeeklyWeatherData()
        setupTableView()
    }
}

// MARK: - UITableViewDataSource
extension WeeklyWeatherViewController: UITableViewDataSource {
    
    func loadWeeklyWeatherData() {
        Task {
            if let weeklyWeatherDTO = try? await weatherService.fetchWeeklyWeather(city: "서울특별시") {
                let viewModels = weeklyWeatherDTO.list.map { dayWeather -> WeatherDTO in
                    let celsiusTemp = dayWeather.temp.day - 273.15
                    let dayOfWeek = convertUnixTimeToDayOfWeek(unixTime: dayWeather.dt)
                    return WeatherDTO(
                        cityName: weeklyWeatherDTO.city.name,
                        temperature: String(format: "%.1fºC", celsiusTemp),
                        condition: dayWeather.weather.first?.main ?? "Not Available",
                        dateString: dayOfWeek
                    )
                }
                DispatchQueue.main.async { [weak self] in
                    self?.weatherViewModels = viewModels
                    self?.myView.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView() {
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        myView.tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

// MARK: - UITableViewDelegate

extension WeeklyWeatherViewController: UITableViewDelegate {
    
    private func convertUnixTimeToDayOfWeek(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeeklyTableViewCell else {
            fatalError("The dequeued cell is not an instance of WeeklyTableViewCell.")
        }
        let viewModel = weatherViewModels[indexPath.row]
        cell.configure(with: viewModel)
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
        return 80 // 또는 원하는 높이 값
    }
}

#if DEBUG

import SwiftUI

struct ViewControllerPresentable : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        WeeklyWeatherViewController()
    }
}

struct ViewControllerPresentable_PreviewProvider : PreviewProvider {
    static var previews: some View{
        ViewControllerPresentable()
            .ignoresSafeArea()
    }
}


#endif
