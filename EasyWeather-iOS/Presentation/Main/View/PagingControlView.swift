//
//  PagingControlView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/7/24.
//

import UIKit

final class PagingControlView: UIView {
    
    // MARK: - Properties
    
    private let numberOfPages: Int
    
    var settingOptions: [SettingOptionModel] = [] {
        didSet {
            mainPagingCollectionView.reloadData()
        }
    }
    
    var weatherResponseData: WeatherResponseType? = nil {
        didSet {
            print(weatherResponseData!.cityName,
                  weatherResponseData!.main.temp,
                  weatherResponseData!.main.temp_max,
                  weatherResponseData!.main.temp_min,
                  weatherResponseData!.main.pressure,
                  weatherResponseData!.main.humidity,
                  weatherResponseData!.sys.sunrise,
                  weatherResponseData!.sys.sunset
            )
            mainPagingCollectionView.reloadData()
        }
    }

    // MARK: - UI Properties
    
    private lazy var navigationBarView = NavigationBarView()
    
    private lazy var mainPagingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(PagingControlCollectionViewCell.self, forCellWithReuseIdentifier: PagingControlCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPage = 0
        control.tintColor = .white
        control.pageIndicatorTintColor = .systemGray4
        control.currentPageIndicatorTintColor = .mainTheme
        
        return control
    }()
    
    // MARK: - Life Cycle
    
    init(numberOfPages: Int) {
        self.numberOfPages = numberOfPages
        
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions : UI & Layout

extension PagingControlView {
    private func setUI() {
        [navigationBarView, mainPagingCollectionView, pageControl].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
            make.height.greaterThanOrEqualTo(30)
        }
        
        mainPagingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top)
        }

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PagingControlView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagingControlCollectionViewCell.identifier, for: indexPath) as! PagingControlCollectionViewCell
        
//        let temp = weatherResponseData?.main.temp
//        cell.configure(withText: "\(String(describing: temp))")
        if let temp = weatherResponseData?.main.temp {
//            print(String(temp).celsiusToFahrenheit()!)
            cell.configure(withText: String(Int(temp)).kelvinToCelsius()!)
        } else {
            // TODO: temp가 nil인 경우 처리할 로직 추가
        }
        
        cell.configureSettingOption(data: settingOptions)
        cell.addTargetForWeekendWeatherButton(target, action: #selector(ViewController.goToWeeklyTableViewController))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// Cell을 컬렉션 뷰의 크기와 동일하게 설정하여 페이지 단위로 스크롤되게 함

extension PagingControlView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

// MARK: - UIScrollViewDelegate
// 페이지 인덱스를 계산하여 페이지 컨트롤의 현재 페이지를 업데이트

extension PagingControlView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width != 0 else { return }
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

// MARK: - Configure

extension PagingControlView {
    func addTargetSettingMenuButton(_ target: Any?, action: Selector) {
        navigationBarView.settingMenuButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
