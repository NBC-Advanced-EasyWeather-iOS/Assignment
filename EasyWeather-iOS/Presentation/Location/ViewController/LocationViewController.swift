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
    
        setUI()
        setLayout()
    }

}

// MARK: - Extensions

extension LocationViewController {
    
    private func setUI() {
        view.backgroundColor = .primaryBackground
        
        view.addSubview(locationView)
    }
    
    private func setLayout() {
        locationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
