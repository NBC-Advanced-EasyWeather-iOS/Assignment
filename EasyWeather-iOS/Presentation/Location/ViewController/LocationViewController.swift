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
        
        hideKeyboard()
    }
    
    override func loadView() {
        view = locationView
    }
}

// MARK: - keyboard 숨김 메서드

extension LocationViewController {
    
    /// 화면밖 터치시 키보드를 내려 주는 메서드
        func hideKeyboard() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                     action: #selector(LocationViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}
