//
//  SplashView.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import UIKit
import SnapKit
import RxSwift

final class SplashView: UIView {
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
    }()
    
    let welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GetSchwifty-Regular", size: 100)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "rick-and-morty-title")
        return imageView
    }()
    
    private let loadingIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .green
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
  
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let rickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "rick")
        return imageView
    }()
    
    private let mortyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "morty")
        return imageView
    }()
    
    let animationFinished = PublishSubject<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeWelcomeMessageText(_ isOpenedBefore: Bool) {
        if isOpenedBefore {
            self.welcomeMessageLabel.text = "Hello!"
        } else {
            self.welcomeMessageLabel.text = "Welcome!"
            UserDefaults.standard.set(true, forKey:  "isOpenedBefore")
        }
    }
    
    //MARK: - Animate UI Elements
    private func animateUIElementsTopToBottom() {
        titleImageView.frame = CGRect(x: 0, y: -titleImageView.frame.size.height, width: titleImageView.frame.size.width, height: 0)
        rickImageView.frame = CGRect(x: 0, y: -self.rickImageView.frame.origin.y, width: rickImageView.frame.size.width, height: 0)
        mortyImageView.frame = CGRect(x: 0, y: -mortyImageView.frame.size.height, width: mortyImageView.frame.size.width, height: 0)
        
        UIView.animate(withDuration: 1.5) { [unowned self] in
            self.titleImageView.frame = CGRect(x: 0, y: 400, width: self.titleImageView.frame.size.width, height: 0)
            self.rickImageView.frame = CGRect(x: 0, y: 200, width: self.rickImageView.frame.size.width, height: 0)
            self.mortyImageView.frame = CGRect(x: 0, y: 400, width: self.mortyImageView.frame.size.width, height: 0)
        } completion: { [unowned self] _ in
            self.loadingIndicator.stopAnimating()
            animateUIElementsToOut()
        }
    }
    
    private func animateUIElementsToOut() {
        UIView.animate(withDuration: 1.0, animations: { [unowned self] in
            self.rickImageView.frame.origin.y = UIScreen.main.bounds.height
            self.mortyImageView.frame.origin.y = UIScreen.main.bounds.height
            self.welcomeMessageLabel.frame.origin.y = UIScreen.main.bounds.height
        }, completion: { [unowned self]  _ in
            self.rickImageView.removeFromSuperview()
            self.mortyImageView.removeFromSuperview()
            self.animationFinished.onNext(())
        })
    }
}

extension SplashView: ViewProtocol {
    
    func configureView() {
        backgroundColor = .white
        addSubview()
        setupConstraints()
        animateUIElementsTopToBottom()
    }
  
    func addSubview() {
        addSubview(topContainerView)
        addSubview(welcomeMessageLabel)
        addSubview(bottomContainerView)
        addSubview(seperatorView)
        addSubview(rickImageView)
        addSubview(mortyImageView)
        elementsToBottomContainerView()
    }
    
    private func elementsToBottomContainerView() {
        bottomContainerView.addSubview(titleImageView)
        bottomContainerView.addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        topContainerViewConstraints()
        welcomeMessageLabelConstraints()
        titleImageViewConstraints()
        titleImageBackgroundViewConstraints()
        seperatorViewConstraints()
        rickImageViewConstraints()
        mortyImageViewConstraints()
        loadingIndicatorConstraints()
        
    
    }
    
    private func topContainerViewConstraints() {
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func welcomeMessageLabelConstraints() {
        welcomeMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.leading.trailing.equalTo(topContainerView)
        }
    }
    private func titleImageBackgroundViewConstraints() {
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
   
    }
    private func titleImageViewConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.top.width.equalTo(bottomContainerView)
            make.height.equalTo(bottomContainerView.snp.height).multipliedBy(0.4)
        }
    }
    
    private func loadingIndicatorConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(bottomContainerView)
        }
    }
    
    private func seperatorViewConstraints() {
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(bottomContainerView.snp.centerX)
            make.width.equalTo(bottomContainerView.snp.width).multipliedBy(0.33)
        }
    }
    private func rickImageViewConstraints() {
        rickImageView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomContainerView.snp.top)
            make.trailing.equalTo(seperatorView.snp.leading)
            make.leading.top.equalTo(safeAreaLayoutGuide)
        }
    }
    private func mortyImageViewConstraints() {
        mortyImageView.snp.makeConstraints { make in
            make.top.equalTo(rickImageView.snp.bottom)
            make.leading.equalTo(seperatorView.snp.leading)
            make.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
   
}
    
    
     

