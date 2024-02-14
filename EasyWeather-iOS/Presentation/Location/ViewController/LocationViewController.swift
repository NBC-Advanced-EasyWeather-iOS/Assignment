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
    }
    
    override func loadView() {
        view = locationView
    }
}
