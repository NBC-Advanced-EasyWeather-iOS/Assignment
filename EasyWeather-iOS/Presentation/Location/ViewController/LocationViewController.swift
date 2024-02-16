//
//  LocationViewController.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/8/24.
//

import UIKit

final class LocationViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var locationView: LocationView
    
    // MARK: - Life Cycle
    
    init(locationView: LocationView = LocationView()) {
        self.locationView = locationView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = locationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CityList.shared.loadCity()
    }
}

// MARK: - 데이터 configure 메서드
extension LocationViewController {
    func configure(city: String, temp: String) {
        locationView.userLocationCaptionLabel.text = city
        locationView.userLocationTemperatureLabel.text = temp
    }
}
