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

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pagingControlView.data = SettingOptionUserDefault.shared.loadOptionsFromUserDefaults()
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
    func goToWeeklyTableViewController() {
        let weeklyTableViewController = WeeklyWeatherViewController(weatherService: WeatherService(), rootView: WeeklyWeatherView())
        self.navigationController?.pushViewController(weeklyTableViewController, animated: true)
    }
}
