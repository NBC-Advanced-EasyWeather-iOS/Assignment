//
//  MeteorologicalCollectionView.swift
//  EasyWeather-iOS
//
//  Created by yen on 2/8/24.
//

import UIKit

final class MeteorologicalCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    var weatherData: WeatherResponseType = WeatherResponseType(
        cityName: "",
        main: Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0),
        sys: Sys(country: "", sunrise: 0, sunset: 0)
    ) {
        didSet {
            print(weatherData)
        }
    }
    
    var settingData: [SettingOptionModel] = [] {
        didSet {
            self.isSun = self.settingData[0].isOn
            self.isTemperature = self.settingData[1].isOn
            self.isATM = self.settingData[2].isOn
            self.isHumidity = self.settingData[3].isOn
            
            reloadData()
        }
    }
    
    private var isSun = true
    private var isTemperature = true
    private var isATM = true
    private var isHumidity = true
    
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
        var itemCount = 0

        if isSun { itemCount += 2 }
        if isTemperature { itemCount += 2 }
        if isATM {
            itemCount += isHumidity ? 2 : 1
        }
        if isHumidity && !isATM {
            itemCount += 1
        }
        
        return itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeteorologicalCollectionViewCell.identifier, for: indexPath)
        
        if let meteorologicalCell = cell as? MeteorologicalCollectionViewCell {
            
            var dataIndex = 0
            
            let (formattedSunrise, formattedSunset) = Date().sunriseAndSunsetStringFromUnixTime(sunriseUnixTime: weatherData.sys.sunrise, sunsetUnixTime: weatherData.sys.sunset)
            let minTemperature = String(Int(weatherData.main.tempMin)).kelvinToCelsius()!
            let maxTemperature = String(Int(weatherData.main.tempMax)).kelvinToCelsius()!
            
            if isSun {
                if indexPath.row == 0 {
                    meteorologicalCell.configure(title: "일출", value: String(describing: formattedSunrise), type: "일출")
                } else if indexPath.row == 1 {
                    meteorologicalCell.configure(title: "일몰", value: String(describing: formattedSunset), type: "일몰")
                }
                dataIndex += 2
            }
            
            if isTemperature {
                if indexPath.row == dataIndex {
                    meteorologicalCell.configure(title: "최저 기온", value: "\(minTemperature) °C", type: "")
                } else if indexPath.row == dataIndex + 1 {
                    meteorologicalCell.configure(title: "최고 기온", value: "\(maxTemperature) °C", type: "")
                }
                dataIndex += 2
            }
            
            if isATM { // 기압
                if isHumidity {
                    if indexPath.row == dataIndex {
                        meteorologicalCell.configure(title: "기압", value: "\(weatherData.main.pressure) hPa", type: "")
                    } else if indexPath.row == dataIndex + 1 {
                        meteorologicalCell.configure(title: "습도", value: "\(weatherData.main.humidity) %", type: "")
                    }
                    dataIndex += 2
                } else {
                    if indexPath.row == dataIndex {
                        meteorologicalCell.configure(title: "기압", value: "\(weatherData.main.pressure) hPa", type: "")
                        dataIndex += 1
                    }
                }
            }
            
            if isHumidity && !isATM {
                if indexPath.row == dataIndex {
                    meteorologicalCell.configure(title: "습도", value: "\(weatherData.main.humidity) %", type: "")
                }
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
