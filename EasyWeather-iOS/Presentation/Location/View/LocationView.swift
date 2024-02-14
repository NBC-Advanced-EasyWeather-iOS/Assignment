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
        label.font = FontLiteral.title2(style: .bold)
       
        return label
    }()
    
    //검색창
    private lazy var locationSearchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.primaryBackground
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
        imageView.tintColor = UIColor.gray
        
        return imageView
    }()
    
    //현재 위치
    private lazy var userLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkTheme
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var userLocationPinIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pin.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.primaryBackground
        
        return imageView
    }()
    private lazy var userLocationBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 위치"
        label.textColor = UIColor.primaryBackground
        label.font = FontLiteral.body(style: .regular)
        
        return label
    }()
    private lazy var userLocationCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "서울시"
        label.textColor = UIColor.systemGray5
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
        button.backgroundColor = UIColor.darkTheme
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var unknownLocationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.primaryBackground
        
        return imageView
    }()
    private lazy var unknownLocationBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 어딘지 모르겠어요 🤔"
        label.textColor = UIColor.primaryBackground
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
        imageView.tintColor = UIColor.primaryBackground
        
        return imageView
    }()
    
    private lazy var listTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "목록"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    //도시 리스트
    private lazy var addedCityListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //검색 결과
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = UIColor.secondaryBackground
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        checkPermission()
        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Extensions : 분기 처리, delegate 메서드

extension LocationView {
    
    private func checkPermission() {
        //위치 권한 분기
        if true {
            unknownLocationButton.isHidden = true
//            userLocationButton.isHidden = true
        }
    }
    
    private func setDelegate () {
        //delegate
        locationTextField.delegate = self
        addedCityListTableView.delegate = self
        addedCityListTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        //cell register
        addedCityListTableView.register(addedCityListTableViewCell.self, forCellReuseIdentifier: "CityList")
        searchResultTableView.register(searchResultTableViewCell.self, forCellReuseIdentifier: "ResultList")
    }
}

// MARK: - Extensions : UI & Layout

extension LocationView {
    
    private func setUI() {
        self.backgroundColor = UIColor.secondaryBackground
        
        //타이틀
        self.addSubview(titleLabel)
        
        //검색창
        self.addSubview(locationSearchView)
        locationSearchView.addSubview(locationSearchIcon)
        locationSearchView.addSubview(locationTextField)
        
        //현재 위치
        self.addSubview(userLocationButton)
        [
            userLocationPinIcon,
            userLocationBodyLabel,
            userLocationCaptionLabel,
            userLocationTemperatureLabel
        ].forEach { userLocationButton.addSubview($0) }
        
        //알 수 없는 위치
        self.addSubview(unknownLocationButton)
        [
            unknownLocationIcon,
            unknownLocationBodyLabel,
            unknownLocationCaptionLabel,
            unknownLocationRightIcon
        ].forEach { unknownLocationButton.addSubview($0) }
        
        //추가한 도시 목록
        self.addSubview(listTitleLabel)
        self.addSubview(addedCityListTableView)
        
        //검색 결과 테이블뷰
        self.addSubview(searchResultTableView)
    }
    
    private func setLayout() {
        //타이틀
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
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
        
        listTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userLocationButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        //도시 리스트
        addedCityListTableView.snp.makeConstraints { make in
            make.top.equalTo(listTitleLabel.snp.bottom).offset(7.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(locationSearchView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extensions : UITextFieldDelegate

extension LocationView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchResultTableView.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchResultTableView.isHidden = true
    }
    
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

// MARK: - Extensions : UITableViewDelegate

extension LocationView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addedCityListTableView {
            return 3
        } else if tableView == searchResultTableView {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == addedCityListTableView {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CityList", for: indexPath) as? addedCityListTableViewCell {
                cell.setCell()
                
                return cell
            }
        } else if tableView == searchResultTableView {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultList", for: indexPath) as? searchResultTableViewCell {
                cell.setCell()
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == addedCityListTableView {
            
            let deleteAction = UIContextualAction(style: .normal, title: "삭제", handler: {(action, view, completionHandler) in
                
                //삭제 로직 구현부
                tableView.reloadData()
            })
            deleteAction.backgroundColor = .red
            
            let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
            swipeActionsConfiguration.performsFirstActionWithFullSwipe = false
            
            return swipeActionsConfiguration
        }
        return nil
    }
}
