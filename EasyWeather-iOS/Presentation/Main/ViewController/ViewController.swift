//
//  ViewController.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import UIKit
import CoreLocation
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var locationManager: CLLocationManager!
    
    // MARK: - UI Properties
    
    private var pagingControlView: PagingControlView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    // 위치 권한 상태 변경시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            // MARK: 위치 권한을 요청하지 않은 경우 - 권한 요청
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            // MARK: 위치 권한을 얻은 경우
            print("Location access granted")
        case .denied, .restricted:
            // MARK: 위치 권한을 얻지 못한 경우 - 위치 검색 페이지로 이동
            print("Location access denied")
//            self.navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true)
        @unknown default:
            fatalError("Unknown location authorization status")
        }
    }
}

// MARK: - Extensions

extension ViewController {
    private func setUI() {
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
