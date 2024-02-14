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
    private var locationViewController = LocationViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        pagingControlView.addTargetLocationMenuButton(self, action: #selector(goToLocationViewController))

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
    func goToLocationViewController() {
        self.navigationController?.pushViewController(locationViewController, animated: true)
    }
}
