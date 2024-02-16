//
//  City.swift
//  EasyWeather-iOS
//
//  Created by 홍희곤 on 2/2/24.
//

import Foundation

final class CityList {
    
    static let shared = CityList()
    
    private let key = "도시 목록"
    
    private init() {}
    
    var searchedCity:[String]?
    var addedCity:[String]?
    
    private let cityList = ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"]
    
    func search(term: String) {
        self.searchedCity = cityList.filter { $0.contains(term) }
    }
    
    func add(city: String) {

        //중복처리, 바인딩
        if let addedCity = addedCity {
            guard !addedCity.contains(city) else { return }
        } else {
            addedCity = []
        }
        
        //추가
        addedCity?.append(city)
    }
}

// MARK: - UserDefaults 메서드

extension CityList {
    
    func saveCity() {
        UserDefaults.standard.set(addedCity, forKey: key)
        
        print ("사용자 도시목록 저장")
    }
    
    func loadCity() -> [String]? {
        if let city = UserDefaults.standard.object(forKey: key) as? [String] {
            addedCity = city
            print("사용자 도시목록 로드")
            return city
        } else {
            return nil
        }
    }
}
