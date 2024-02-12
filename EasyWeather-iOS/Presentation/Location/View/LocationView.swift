//
//  LocationView.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/8/24.
//

import UIKit

final class LocationView: UIView {
    
    // MARK: - UI Properties
    
    //타이틀
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 위치 추가하기"
        label.textColor = UIColor(named: "Label/Primary")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
       
        return label
    }()
    
    //검색창
    private lazy var locationSearchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "위치 검색 및 추가"
        
        return textField
    }()
    private lazy var locationSearchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        
        return imageView
    }()
    
    //현재 위치
    private lazy var userLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "4E628B")
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var userLocationPinIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pin.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    private lazy var userLocationBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 위치"
        label.textColor = .white
        label.font = FontLiteral.body(style: .regular)
        
        return label
    }()
    private lazy var userLocationCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "서울시"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        return label
    }()
    private lazy var userLocationTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "0℃"
        label.textColor = .white
        label.font = FontLiteral.body(style: .regular)
        
        return label
    }()
    
    //알 수 없는 위치
    private lazy var unknownLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "4E628B")
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var unknownLocationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    private lazy var unknownLocationBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 어딘지 모르겠어요 🤔"
        label.textColor = .white
        label.font = FontLiteral.body(style: .regular)
        
        return label
    }()
    private lazy var unknownLocationCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 접근 권한을 허용해주세요"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        return label
    }()
    private lazy var unknownLocationRightIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    
    //도시 리스트
    private lazy var addedCityListTableView = UITableView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        //위치 권한 분기
        if true {
//            unknownLocationButton.isHidden = true
            userLocationButton.isHidden = true
        }
        
        self.backgroundColor = UIColor(hex: "F2F2F7")
        locationTextField.delegate = self
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions : UI & Layout

extension LocationView {
    
    private func setUI() {
        //타이틀
        self.addSubview(titleLabel)
        
        //검색창
        self.addSubview(locationSearchView)
        locationSearchView.addSubview(locationSearchIcon)
        locationSearchView.addSubview(locationTextField)
        
        //현재 위치
        self.addSubview(userLocationButton)
        userLocationButton.addSubview(userLocationPinIcon)
        userLocationButton.addSubview(userLocationBodyLabel)
        userLocationButton.addSubview(userLocationCaptionLabel)
        userLocationButton.addSubview(userLocationTemperatureLabel)
        
        //알 수 없는 위치
        self.addSubview(unknownLocationButton)
        unknownLocationButton.addSubview(unknownLocationIcon)
        unknownLocationButton.addSubview(unknownLocationBodyLabel)
        unknownLocationButton.addSubview(unknownLocationCaptionLabel)
        unknownLocationButton.addSubview(unknownLocationRightIcon)
    }
    
    private func setLayout() {
        //타이틀
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        //검색창
        locationSearchView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        locationSearchIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(locationSearchIcon.snp.height)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(locationSearchIcon.snp.trailing).offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        //현재 위치
        userLocationButton.snp.makeConstraints { make in
            make.top.equalTo(locationSearchView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        userLocationPinIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(locationSearchIcon.snp.height)
        }
        userLocationBodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(userLocationPinIcon.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10.5)
        }
        userLocationCaptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(userLocationPinIcon.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10.5)
        }
        userLocationTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        //알 수 없는 위치
        unknownLocationButton.snp.makeConstraints { make in
            make.top.equalTo(locationSearchView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        unknownLocationIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(locationSearchIcon.snp.height)
        }
        unknownLocationBodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(unknownLocationIcon.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10.5)
        }
        unknownLocationCaptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(unknownLocationIcon.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10.5)
        }
        unknownLocationRightIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
}

// MARK: - Extensions : UITextFieldDelegate

extension LocationView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력된 문자열을 검색 쿼리로 사용하여 검색을 수행하고, 검색 결과를 업데이트합니다.
        let searchString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        updateSearchResults(for: searchString)
        return true
    }
    
    func updateSearchResults(for searchText: String) {
        print("검색 결과: \(searchText)")
    }
}
