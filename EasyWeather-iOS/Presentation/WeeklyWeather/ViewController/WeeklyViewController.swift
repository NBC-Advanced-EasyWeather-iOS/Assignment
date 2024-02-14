//
//  WeeklyViewController.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//


import UIKit

final class WeeklyTableViewController: UIViewController {
    
    // MARK: - Properties
    let myView = WeeklyWeatherView()
    let weatherData = WeatherData.shared.getWeatherData()
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
    }
}

extension WeeklyTableViewController: UITableViewDataSource {
    
    // MARK: - Layout

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "이번 주 날씨"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeeklyTableViewCell else {
            fatalError("The dequeued cell is not an instance of WeeklyTableViewCell.")
        }
        let weather = weatherData[indexPath.row]
        
        
        cell.dateLabel.text = weather.dayOfWeek
        cell.weatherLabel.text = weather.weatherCondition
        cell.temperatureLabel.text = weather.temperature
        
        return cell
    }
    
}

// MARK: - UITableView Delegate
extension WeeklyTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = tableView.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width: tableView.bounds.size.width, height: 25))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20) // Adjust this value for desired top padding
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
        WeeklyTableViewController()
    }
}

struct ViewControllerPresentable_PreviewProvider : PreviewProvider {
    static var previews: some View{
        ViewControllerPresentable()
            .ignoresSafeArea()
    }
}


#endif
