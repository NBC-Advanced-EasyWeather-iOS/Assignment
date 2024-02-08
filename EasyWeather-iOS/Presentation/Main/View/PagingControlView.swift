//
//  PagingControlView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/7/24.
//

import UIKit

import SnapKit

final class PagingControlView: UIView {
    
    // MARK: - UI Properties
    
    private lazy var navigationBarView = NavigationBarView()
    
    private lazy var mainWeatherCollectionView: UICollectionView = {
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
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPage = 0
        control.tintColor = .white
        control.pageIndicatorTintColor = .systemGray4
        control.currentPageIndicatorTintColor = .systemBlue
        
        return control
    }()
    
    // MARK: - Properties
    
    private let numberOfPages: Int
    
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
        [navigationBarView, mainWeatherCollectionView, pageControl].forEach {
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
        
        mainWeatherCollectionView.snp.makeConstraints { make in
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: cell.contentView.frame.width - 40, height: 100))
        label.text = "Test page \(indexPath.row + 1)"
        label.textColor = UIColor(named: "Label/Primary")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        
        cell.contentView.addSubview(label)
        cell.backgroundColor = .darkTheme
        
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
