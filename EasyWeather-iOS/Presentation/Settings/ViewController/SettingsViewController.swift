
import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    
    var data = SettingOptionUserDefault.shared.loadOptionsFromUserDefaults()

    var additionalDisplayOptions: [SettingOptionModel] = []
    var unitChangeOptions: [SettingOptionModel] = []
    
    // MARK: - UI Properties
    
    var collectionView: UICollectionView?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        createCollectionView()
        setUserDefaultsData()
    }
}

// MARK: - Extensions

extension SettingsViewController {
    private func setUI() {
        view.backgroundColor = UIColor.secondaryBackground
        
        setUserDefaultsData() // 데이터 설정 추가
//        print(data)
    }
    
    private func setUserDefaultsData() {
        additionalDisplayOptions = Array(data.prefix(4)) // 처음 4개의 데이터를 추가 표시 옵션으로 설정
        unitChangeOptions = Array(data.suffix(2)) // 마지막 2개의 데이터를 단위 변경 옵션으로 설정
    }
}

// MARK: - Extensions

extension SettingsViewController {
    private func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .lightTheme
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(SettingOptionCell.self, forCellWithReuseIdentifier: SettingOptionCell.identifier)
        collectionView?.register(SettingHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingHeader.identifier)

        if let collectionView = collectionView {
            view.addSubview(collectionView)
            
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            for i in 0 ..< unitChangeOptions.count {
                unitChangeOptions[i].isOn = false
            }
            unitChangeOptions[indexPath.row].isOn = true
            
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
            
        } else {
            let option = additionalDisplayOptions[indexPath.row]
            option.isOn.toggle()
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? SettingOptionCell else { return }
            cell.updateAppearance(isOn: additionalDisplayOptions[indexPath.item].isOn)
            
            UserDefaults.standard.set(additionalDisplayOptions[indexPath.row].isOn, forKey: additionalDisplayOptions[indexPath.row].title)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return additionalDisplayOptions.count
        } else {
            return unitChangeOptions.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SettingOptionCell.identifier,
            for: indexPath
        ) as? SettingOptionCell else {
            fatalError("Unable to dequeue SettingOptionCell")
        }
        
        if indexPath.section == 0 {
            cell.configure(with: additionalDisplayOptions[indexPath.row])
        } else {
            cell.configure(with: unitChangeOptions[indexPath.row])
        }
        
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
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        // 가로 크기: 세로 크기 = 3:1 인 직사각형이 되도록
        return CGSize(width: widthPerItem, height: widthPerItem / 3)
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
