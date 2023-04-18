//
//  MainView.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 12.04.2023.
//

import UIKit

class MainView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick and Morty"
        label.textAlignment = .center
        label.font = UIFont(name: "GetSchwifty-Regular", size: 50)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    private let  firstSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 0.5
        view.layer.masksToBounds = true
        return view
    }()
   
    let locationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.identifier)
        collection.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.identifier)
        return collection
    }()
   
    private let secondSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 0.5
        view.layer.masksToBounds = true
        return view
    }()
    
    let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        return collection
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "GetSchwifty-Regular", size: 50)
        return label
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .green
        indicator.hidesWhenStopped = true
        return indicator
    }()
//    MARK: - Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    configureView()
    }
   
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK: - Change Message Label Text
    
    func ChangeMessageLabelText(hide: Bool) {
        switch hide {
        case true:
            messageLabel.isHidden = hide
        case false:
            messageLabel.isHidden = hide
            messageLabel.text = "There is no character at this location"
            
        }
            
        }
        
    }
    
//    MARK: - UI Elements AddSubview / Setup Constraints
extension MainView: ViewProtocol {
    
//    MARK: - Configure View
    func configureView() {
        backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    private func elementsToScrollView() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(firstSeperatorView)
        scrollView.addSubview(locationsCollectionView)
        scrollView.addSubview(secondSeperatorView)
        scrollView.addSubview(charactersCollectionView)
        charactersCollectionView.addSubview(messageLabel)
        scrollView.addSubview(indicator)
    }
   
    func addSubview() {
        addSubview(scrollView)
        elementsToScrollView()
    }
//    MARK: - Setup Constraints
    func setupConstraints() {
        scrollViewConstraints()
        titleLabelConstraints()
        firstSeperatorViewConstraints()
        locationsCollectionViewConstraints()
        secondSeperatorViewConstraints()
        charactersCollectionViewConstraints()
        messageLabelConstraints()
        indicatorConstraints()
    }
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
        
    }
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading).offset(15)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            make.centerX.equalTo(scrollView)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-15)
        }
    }
    private func firstSeperatorViewConstraints() {
        firstSeperatorView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(scrollView.snp.width).multipliedBy(0.9)
            make.height.equalTo(1)
            make.centerX.equalTo(scrollView)
        }
    }
    private func locationsCollectionViewConstraints() {
        locationsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstSeperatorView.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            
        }
    }
    private func secondSeperatorViewConstraints() {
        secondSeperatorView.snp.makeConstraints { make in
            make.top.equalTo(locationsCollectionView.snp.bottom)
            make.width.height.centerX.equalTo(firstSeperatorView)
        }
    }
    private func charactersCollectionViewConstraints() {
        charactersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondSeperatorView.snp.bottom).offset(5)
            make.width.equalTo(secondSeperatorView)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(scrollView.snp.height)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    private func messageLabelConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(charactersCollectionView.snp.leading).offset(10)
            make.trailing.equalTo(charactersCollectionView.snp.trailing).offset(-10)
        }
    }
    private func indicatorConstraints() {
        indicator.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
            make.height.width.equalTo(locationsCollectionView.snp.height)
        }
    }
}
