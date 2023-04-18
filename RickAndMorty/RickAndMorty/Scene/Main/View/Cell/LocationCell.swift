//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import UIKit

protocol LocationCellProtocol {
    var locationCellName: String { get }
}

final class LocationCell: UICollectionViewCell {
    
    static let identifier = "LocationCell"
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.changeColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 2
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ data: LocationCellProtocol) {
        locationLabel.text = data.locationCellName
    }
    
    private func changeColor() {
        switch self.isSelected {
        case true:
            let duration: CGFloat = 0
            UIView.animate(withDuration: duration, delay: 0) {
                self.locationLabel.textColor = .black
                self.backgroundColor = .white
            }
        case false:
            let duration: CGFloat = 0.3
            UIView.animate(withDuration: duration, delay: 0) {
                self.locationLabel.textColor = .white
                self.backgroundColor = .black
            }
        }
    }
    
}
//MARK: - UI Elements AddSubview / Setup Constraints
extension LocationCell: CellProtocol {
    func configureCell() {
        backgroundColor = .black
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(locationLabel)
    }
    
    func setupConstraints() {
        locationLabelConstraints()
    }
    
    private func locationLabelConstraints() {
        locationLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.leading.top.trailing.bottom.equalTo(contentView)
        }
    }

}
