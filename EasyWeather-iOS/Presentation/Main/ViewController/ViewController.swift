//
//  ViewController.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {
    
   // MARK: - Properties
    
    private let weatherService = WeatherService()
    
    var locationUserDefaultsKey: [String] = [] {
        didSet {
            print(locationUserDefaultsKey)
            pagingControlView.numberOfPages = locationUserDefaultsKey.count + 1
        }
    }
    
    var locationUserDefaultsData: [WeatherResponseType] = [] {
        didSet {
            if locationUserDefaultsKey.count == locationUserDefaultsData.count {
                pagingControlView.locationResponseData = locationUserDefaultsData
            }
        }
    }
     
    // MARK: - UI Properties
    
    private var pagingControlView: PagingControlView!
    private var settingsViewController = SettingsViewController()
    private var weeklyTableViewController = WeeklyWeatherViewController()
    private var locationViewController = LocationViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 1)
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pagingControlView.settingOptions = SettingOptionUserDefault.shared.loadOptionsFromUserDefaults()
        self.locationUserDefaultsKey = CityList.shared.loadCity() ?? []
        
        fetchCurrentWeather()
        fetchLocationWeather()
        
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
        pagingControlView.addTargetLocationButton(self, action: #selector(goToLocationViewController))

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
        let hour = Calendar.current.component(.hour, from: Date())
        
        var topColor = UIColor.nightBackgroundTop.cgColor
        var bottomColor = UIColor.nightBackgroundTop.cgColor
        
        switch hour {
        case 0...5: // 밤
            topColor = UIColor.nightBackgroundTop.cgColor
            bottomColor = UIColor.dayBackgroundTop.cgColor
        case 6...11: // 오전
            topColor = UIColor.dayBackgroundTop.cgColor
            bottomColor = UIColor.primaryBackground.cgColor
        case 12...17: // 오후
            topColor = UIColor.eveningBackgroundTop.cgColor
            bottomColor = UIColor.primaryBackground.cgColor
        case 18...23: // 저녁
            topColor = UIColor.nightBackgroundTop.cgColor
            bottomColor = UIColor.dayBackgroundTop.cgColor
        default:
            break
        }
        
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
    func goToLocationViewController() {
        self.navigationController?.pushViewController(locationViewController, animated: true)
    }
}

extension ViewController {
    private func fetchCurrentWeather() {
        let city = UserDefaults.standard.string(forKey: "city") ?? "-"
        
        Task(priority: .userInitiated) {
            do {
                let response = try await weatherService.fetchCurrnetWeather(city: city)
                let data: WeatherResponseType = WeatherResponseType(cityName: response.name, main: response.main, sys: response.sys)
                handleWeatherResponse(data)
            } catch {
                print("Error fetching current weather: \(error)")
            }
        }
    }
    
    private func handleWeatherResponse(_ response: WeatherResponseType) {
        pagingControlView.weatherResponseData = response
        locationViewController.configure(city: response.cityName, temp: "\(String(Int(response.main.temp)).kelvinToCelsius()!) °C")
    }
    
    private func fetchLocationWeather() {
        for city in locationUserDefaultsKey {
            Task(priority: .userInitiated) {
                do {
                    let response = try await weatherService.fetchCurrnetWeather(city: city)
                    let data: WeatherResponseType = WeatherResponseType(cityName: response.name, main: response.main, sys: response.sys)
                    locationUserDefaultsData.append(data)
                } catch {
                    print("Error fetching current weather: \(error)")
                }
            }
        }
    }
}
