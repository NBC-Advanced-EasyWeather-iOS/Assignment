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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 날씨쪽 콜렉션뷰 리로드해야하는 부분
        SettingOptionUserDefault.shared.loadOptionsFromUserDefaults().forEach {
            print($0.isOn, $0.title) // 잘됨
        }
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
