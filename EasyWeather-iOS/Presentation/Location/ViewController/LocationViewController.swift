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
        cityNameText(data: city)
        locationView.userLocationTemperatureLabel.text = temp
    }
    
    private func cityNameText(data: String) {
        switch data {
        case "Suwon-si":
            locationView.userLocationCaptionLabel.text = "수원시"
        case "Seoul":
            locationView.userLocationCaptionLabel.text = "서울특별시"
        case "Busan":
            locationView.userLocationCaptionLabel.text = "부산광역시"
        case "Daegu":
            locationView.userLocationCaptionLabel.text = "대구광역시"
        case "Incheon":
            locationView.userLocationCaptionLabel.text = "인천광역시"
        case "Gwangju":
            locationView.userLocationCaptionLabel.text = "광주광역시"
        case "Daejeon":
            locationView.userLocationCaptionLabel.text = "대전광역시"
        case "Ulsan":
            locationView.userLocationCaptionLabel.text = "울산광역시"
        default:
            break
        }
    }
}
