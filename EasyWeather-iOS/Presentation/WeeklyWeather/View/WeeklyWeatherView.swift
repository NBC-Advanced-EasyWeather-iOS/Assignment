//
//  WeeklyView.swift
//  EasyWeather-iOS
//
//  Created by t2023-m0051 on 2/11/24.
//

import UIKit
import SnapKit

class WeeklyWeatherView: UIView {
    let imageView = UIImageView()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        // 이미지 뷰 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        addSubview(imageView)

        // 테이블 뷰 설정
        tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)

        // SnapKit을 사용하여 오토레이아웃 설정
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.30)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            //make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        }
    }
}

