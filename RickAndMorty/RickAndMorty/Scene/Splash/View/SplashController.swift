//
//  SplashController.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import UIKit
import RxSwift

final class SplashController: UIViewController {
    
    var splashView = SplashView()
    
    private let disposeBag = DisposeBag()
    
    let isOpenedBefore = UserDefaults.standard.bool(forKey: "isOpenedBefore")
    
    override func loadView() {
        super.loadView()
        checkIsOpenedBefore()
        view = splashView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureViewController()
        
    }
    
    private func checkIsOpenedBefore() {
        self.splashView
            .changeWelcomeMessageText(isOpenedBefore)
    }
    
    private func ConfigureViewController() {
        navigationController?.isNavigationBarHidden = true
        createCallBacks()
        
    }
    private func createCallBacks() {
        animationFinishedCallBack()
    }
    
    private func animationFinishedCallBack() {
        splashView.animationFinished.subscribe { [weak self] _ in
            self?.goToMainController()
        } .disposed(by: disposeBag)
    }
    
    private func goToMainController() {
        let mainController = MainController()
        self.navigationController?.pushViewController(mainController, animated: true)
        self.removeFromParent()
    }
}
