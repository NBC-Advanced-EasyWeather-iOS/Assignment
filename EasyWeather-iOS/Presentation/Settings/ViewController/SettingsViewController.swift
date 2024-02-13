
import UIKit

// MARK: - ViewController

class SettingsViewController: UIViewController {
    var collectionView: UICollectionView?
    
    // MARK: - Properties for layout calculation
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    
    var settingSections: [[SettingOptionModel]] = [
        [SettingOptionModel(title: "일출/일몰 시간", isOn: true), SettingOptionModel(title: "최저/최고 기온", isOn: false),
         SettingOptionModel(title: "기압", isOn: true), SettingOptionModel(title: "습도", isOn: false)],
        [SettingOptionModel(title: "섭씨온도 °C", isOn: true), SettingOptionModel(title: "화씨온도 °F", isOn: false)]
    ]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionView()
        view.backgroundColor = .lightTheme
    }
    
    private func initializeCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView?.backgroundColor = .lightTheme
            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.register(SettingOptionCell.self, forCellWithReuseIdentifier: SettingOptionCell.identifier)
            collectionView?.register(SettingHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingHeader.identifier)
            
            if let collectionView = collectionView {
                view.addSubview(collectionView)
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            for i in 0..<settingSections[indexPath.section].count {
                settingSections[indexPath.section][i].isOn = false
            }
            settingSections[indexPath.section][indexPath.item].isOn = true
            
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        } else {
            
            let option = settingSections[indexPath.section][indexPath.item]
            option.isOn.toggle()
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? SettingOptionCell else { return }
            cell.updateAppearance(isOn: option.isOn)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingSections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingOptionCell.identifier, for: indexPath) as? SettingOptionCell else {
            fatalError("Unable to dequeue SettingOptionCell")
        }
        let option = settingSections[indexPath.section][indexPath.item]
        cell.configure(with: option)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingHeader.identifier, for: indexPath) as? SettingHeader else {
            fatalError("Unable to dequeue SettingHeader")
        }
        let title = indexPath.section == 0 ? "추가 표시 옵션" : "단위 변경"
        header.configure(with: title)
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem / 3) // 가로 크기: 세로 크기 = 3:1 인 직사각형이 되도록
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
        return CGSize(width: width, height: 50) // 헤더 뷰의 높이 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
