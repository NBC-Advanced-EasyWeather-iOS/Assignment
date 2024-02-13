//
//  MeteorologicalCollectionView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/8/24.
//

import UIKit

final class MeteorologicalCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    let tempdata: [String] = ["data 1","data 2","data 3","data 4","data 5","data 6"]
    
    // MARK: - Life Cycle
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions : UI

extension MeteorologicalCollectionView {
    private func setUI() {
        dataSource = self
        delegate = self
        register(MeteorologicalCollectionViewCell.self, forCellWithReuseIdentifier: MeteorologicalCollectionViewCell.identifier)
        
        isPagingEnabled = true // 스크롤 뷰가 페이지 단위로 스크롤 되도록 설정
        showsHorizontalScrollIndicator = false // 수평 스크롤 인디케이터 숨김
        
        backgroundColor = .clear
    }
}

// MARK: - UICollectionViewDataSource

extension MeteorologicalCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeteorologicalCollectionViewCell.identifier, for: indexPath)
        
        if let meteorologicalCell = cell as? MeteorologicalCollectionViewCell {
            if indexPath.row == 0 {
                meteorologicalCell.configure(withText: "\(tempdata[indexPath.row])", type: "일출")
            } else if indexPath.row == 1 {
                meteorologicalCell.configure(withText: "\(tempdata[indexPath.row])", type: "일몰")
            } else {
                meteorologicalCell.configure(withText: "\(tempdata[indexPath.row])", type: "")
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MeteorologicalCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let numberOfRows: CGFloat = 3
        
        let width = collectionView.bounds.width / itemsPerRow
        let height = collectionView.bounds.height / numberOfRows
        
        return CGSize(width: width, height: height)
    }
}