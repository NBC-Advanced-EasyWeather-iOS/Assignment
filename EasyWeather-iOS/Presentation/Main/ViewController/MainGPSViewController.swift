//
//  MainGPSViewController.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/13/24.
//

import UIKit
import CoreLocation

final class MainGPSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var locationManager: CLLocationManager?
    
    // MARK: - UI Properties
    
    private var viewController = ViewController()
    private var settingsViewController = SettingsViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        setUI()
    }
}

// MARK: - CLLocationManagerDelegate

extension MainGPSViewController: CLLocationManagerDelegate {
    // 위치 권한 상태 변경시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            // MARK: 위치 권한을 요청하지 않은 경우 - 권한 요청
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            // MARK: 위치 권한을 얻은 경우 - 메인화면 이동
            self.navigationController?.pushViewController(viewController, animated: true)
        case .denied, .restricted:
            // MARK: 위치 권한을 얻지 못한 경우 - 위치 검색 페이지로 이동
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        @unknown default:
            fatalError("Unknown location authorization status")
        }
    }
}

// MARK: - Extensions

extension MainGPSViewController {
    private func setUI() {
        view.backgroundColor = .mainTheme
        
        self.navigationController?.isNavigationBarHidden = true
    }
}
