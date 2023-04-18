//
//  LoadingCell.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 12.04.2023.
//

import UIKit

final class LoadingCell: UICollectionViewCell {
    static let identifier = "LoadingCell"
    
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.text = "The end of the locations"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.isHidden = true
        return label
        
    }()
    
    var alertLabelIsHidden: Bool = true {
        didSet {
            if alertLabelIsHidden == false {
                self.alertLabelIsHidden = false
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LoadingCell: CellProtocol {
    
    
    func configureCell() {
        isUserInteractionEnabled = false
        addSubview()
        setupConstraints()
    }
   
    func addSubview() {
        contentView.addSubview(loadingIndicator)
        contentView.addSubview(alertLabel)
    }
    
    func setupConstraints() {
        loadingIndicatorConstraints()
        alertLabelConstraints()
    }
    
    private func loadingIndicatorConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.height.width.equalTo(contentView.snp.height)
        }
    }
    private func alertLabelConstraints() {
        alertLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.height.width.equalTo(contentView)
        }
    }
}
