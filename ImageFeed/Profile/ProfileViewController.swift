//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 09.11.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
   
    
    //MARK: -Overrides Methods
    override func viewDidLoad() {
        makeProfileView()
    }
    
    //MARK: -Private Methods
    private func makeProfileView() {
        
        //добавляем картинку профиля
        let profileImage = UIImage(named: "PhotoUser")
        let imageView = UIImageView(image: profileImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 76).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        //добавляем кнопку выхода из профиля
        let exitProfileButton = UIButton.systemButton(
            with: UIImage(named: "Exit")!,
            target: self,
            action: #selector(Self.didTapExitButton)
        )
        exitProfileButton.tintColor = UIColor(named: "YP Red")
        
        exitProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(exitProfileButton)
        exitProfileButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        exitProfileButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        exitProfileButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        exitProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        //добавляем текстовые поля
        let nameLabel = UILabel()
        let nickNameLabel = UILabel()
        let descriptionLabel = UILabel()
        
        nameLabel.text = "Екатерина Новикова"
        nickNameLabel.text = "@ekaterina_nov"
        descriptionLabel.text = "Hello World!"
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        
        nickNameLabel.textColor = UIColor(named: "YP Gray")
        nickNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        view.addSubview(nickNameLabel)
        view.addSubview(descriptionLabel)
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nickNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
    }
    
    @objc
    private func didTapExitButton() {}
    
    
}
