//
//  City.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/2/24.
//

import Foundation

final class CityList {
    
    static let shared = CityList()
    private init() {}
    
    var searchedCity:[String]?
    var addedCity:[String]?
    
    private let cityList = ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"]
    
    func search(term: String) {
        self.searchedCity = cityList.filter { $0.contains(term) }
    }
    
    func add(city: String) {

        //바인딩
        guard var addedCity = addedCity else { return }
        
        //중복처리
        guard !addedCity.contains(city) else { return }
        
        //배열에 추가
        addedCity.append(city)
    }
}
