//
//  ViewController.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var pagingControlView: PagingControlView!
    private var settingsViewController = SettingsViewController()
    private var weeklyTableViewController = WeeklyWeatherViewController()
    
    private let weatherService = WeatherService()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pagingControlView.settingOptions = SettingOptionUserDefault.shared.loadOptionsFromUserDefaults()
        
//        print(UserDefaults.standard.string(forKey: "city")!)
        fetchCurrentWeather()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Extensions

extension ViewController {
    private func setUI() {
        pagingControlView.addTargetSettingMenuButton(self, action: #selector(goToSettingsViewController))

        setBackgroundColor()
        self.navigationController?.isNavigationBarHidden = true
        
        [pagingControlView].forEach {
            view.addSubview($0)
        }
    }

    private func setLayout() {
        pagingControlView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setBackgroundColor() {
        // 낮
        let topColor = UIColor.dayBackgroundTop.cgColor
        let bottomColor = UIColor.primaryBackground.cgColor
        
        // 오후 ~ 저녁
//        let topColor = UIColor.eveningBackgroundTop.cgColor
//        let bottomColor = UIColor.primaryBackground.cgColor
        
        // 밤
//        let topColor = UIColor.nightBackgroundTop.cgColor
//        let bottomColor = UIColor.dayBackgroundTop.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension ViewController {
    @objc
    func goToSettingsViewController() {
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc
    func goToWeeklyTableViewController() {
        self.navigationController?.pushViewController(weeklyTableViewController, animated: true)
    }
}

extension ViewController {
    private func fetchCurrentWeather() {
        let city = UserDefaults.standard.string(forKey: "city")!
        
        Task(priority: .userInitiated) {
            do {
                let response = try await weatherService.fetchCurrnetWeather(city: city)
                let data: WeatherResponseType = WeatherResponseType(cityName: response.name, main: response.main, sys: response.sys)
                handleWeatherResponse(data)
//                print(response)
            } catch {
                print("Error fetching current weather: \(error)")
            }
        }
    }
    
    private func handleWeatherResponse(_ response: WeatherResponseType) {
//        print(response)
        pagingControlView.weatherResponseData = response
    }
}
