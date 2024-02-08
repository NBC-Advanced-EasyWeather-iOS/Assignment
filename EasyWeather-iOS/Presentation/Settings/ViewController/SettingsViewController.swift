
import UIKit

// MARK: - Custom UICollectionViewCell


// MARK: - SettingOption Model

class SettingOption {
    let title: String
    var isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}



// MARK: - Custom UICollectionViewCell
class SettingOptionCell: UICollectionViewCell {
    
    static let identifier = "SettingOptionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(checkImageView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor, constant: -10),
            
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            checkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with option: SettingOption) {
        titleLabel.text = option.title
        updateAppearance(isOn: option.isOn)
    }

    func updateAppearance(isOn: Bool) {
        self.backgroundColor = isOn ? .white : UIColor(hex: "F2F2F7")
        checkImageView.image = isOn ? UIImage(named: "checkedImage") : UIImage(named: "uncheckedImage")
    }

    
    private func setupBorder() {
        self.layer.borderWidth = 1.0 // 테두리 너비 설정
        self.layer.borderColor = UIColor.white.cgColor // 테두리 색상을 검정색으로 설정
        self.layer.cornerRadius = 20 // 모서리를 20으로 둥글게 설정
        self.layer.masksToBounds = false
        self.clipsToBounds = false // 그림자를 보여주기 위해 false로 설정
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1 //그림자의 투명도를 설정 0은 투명, 1은 완전 불투명을 의미
        self.layer.shadowOffset = CGSize(width: 1, height: 2) //그림자 방향과 거리를 설정
        self.layer.shadowRadius = 5 //그림자 블러 반경
        // 테두리에 맞는 그림자 경로 설정
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        }
}

// MARK: - Custom UICollectionReusableView for headers
class SettingHeader: UICollectionReusableView {
    static let identifier = "SettingHeader"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - ViewController
class SettingsViewController: UIViewController {
    var collectionView: UICollectionView!
    
    // MARK: - Properties for layout calculation
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    
    var settingSections: [[SettingOption]] = [
        [SettingOption(title: "일출/일몰 시간", isOn: true), SettingOption(title: "최저/최고 기온", isOn: false),
         SettingOption(title: "기압", isOn: true), SettingOption(title: "습도", isOn: false)],
        [SettingOption(title: "섭씨온도", isOn: true), SettingOption(title: "화씨온도", isOn: false)]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        view.backgroundColor = UIColor(hex: "F2F2F7")
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(hex: "F2F2F7")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingOptionCell.self, forCellWithReuseIdentifier: SettingOptionCell.identifier)
        collectionView.register(SettingHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingHeader.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 단위 변경 섹션 상호 배타적 선택
        if indexPath.section == 1 { // 단위 변경 섹션 두 번째 섹션(index 1)
            // 해당 섹션의 모든 옵션을 비활성화
            for i in 0..<settingSections[indexPath.section].count {
                settingSections[indexPath.section][i].isOn = false
            }
            // 선택된 옵션만 활성화
            settingSections[indexPath.section][indexPath.item].isOn = true
            
            // 섹션 내 모든 셀을 업데이트
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        } else {
            // 다른 섹션의 로직
            let option = settingSections[indexPath.section][indexPath.item]
            option.isOn.toggle()
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? SettingOptionCell else { return }
            cell.updateAppearance(isOn: option.isOn)
        }
        
        // 선택 효과 제거
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

extension UIColor {
   convenience init(hex: String) {
       let scanner = Scanner(string: hex)
       var rgbValue: UInt64 = 0
       scanner.scanHexInt64(&rgbValue)

       let r = (rgbValue & 0xff0000) >> 16
       let g = (rgbValue & 0xff00) >> 8
       let b = rgbValue & 0xff

       self.init(
           red: CGFloat(r) / 0xff,
           green: CGFloat(g) / 0xff,
           blue: CGFloat(b) / 0xff, alpha: 1
       )
   }
}
