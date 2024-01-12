//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 01.01.2024.
//

import Foundation
import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    //MARK: -private properties
    private let oath2Service = OAuth2Service()
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private let showAuthentificationScreenSegueIdentifer = "ShowAutentificationScreen"
    
    //MARK: -ovverride methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if oauth2TokenStorage.token != nil {
            //flow image
            switchToTabBarController()
        } else {
            //flow authorization
            performSegue(withIdentifier: showAuthentificationScreenSegueIdentifer , sender: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK: -private methods
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Invalid Configuration")
        }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

//MARK: -Extensions
extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthentificationScreenSegueIdentifer {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {fatalError("Failed to prepare for \(showAuthentificationScreenSegueIdentifer)")}
            viewController.delegate = self
                             } else {
                super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAutenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [ weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    private func fetchOAuthToken(_ code: String) {
        oath2Service.fetchOAuthToken(code) { [ weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let accessToken):
                self.oauth2TokenStorage.token = accessToken
                self.switchToTabBarController()
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                break
            }
        }
    }
    
}
