//
//  SplashViewController.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/13/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "Logo")
        
        return imageView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        setLayout()
    }
    
}

// MARK: - Extensions

extension SplashViewController {
    private func setUI() {
        view.backgroundColor = .mainTheme
        
        view.addSubview(logoImage)
    }
    
    private func setLayout() {
        logoImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
}
