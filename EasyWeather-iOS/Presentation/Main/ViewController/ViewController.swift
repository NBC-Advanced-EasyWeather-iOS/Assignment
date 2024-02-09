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

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingControlView = PagingControlView(numberOfPages: 3)
        
        setUI()
        setLayout()
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
