//
//  LocationViewController.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/8/24.
//

import UIKit

final class LocationViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var locationView = LocationView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CityList.shared.loadCity()
    }
    
    override func loadView() {
        view = locationView
    }
}

// MARK: - 데이터 configure 메서드
extension LocationViewController {
    func configure(city: String, temp: String) {
        locationView.userLocationCaptionLabel.text = city
        locationView.userLocationTemperatureLabel.text = temp
    }
}
