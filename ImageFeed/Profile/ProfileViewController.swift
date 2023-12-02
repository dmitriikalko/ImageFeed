//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 09.11.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: -Private Properies
    
    //картинка профиля
    private let userImage = UIImage(named: "PhotoUser")
    private let defaultProfileImage = UIImage(systemName: "person.crop.circle.fill")
    
    //imageView
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView(image: userImage)

       imageView.translatesAutoresizingMaskIntoConstraints = false
       
       return imageView
    }()
    
    //button
    private lazy var exitProfileButton: UIButton =  {
        let button = UIButton.systemButton(
            with: UIImage(named: "Exit")!,
            target: self,
            action: #selector(Self.didTapExitButton)
        )
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //label1
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = UIColor(named: "YP White")
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //label2
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = UIColor(named: "YP Gray")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //label3
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = UIColor(named: "YP White")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -Overrides Methods
    override func viewDidLoad() {
        addSubViews()
        applyConstraints()
    }

    
    //MARK: -Private Methods
    private func addSubViews() {
        view.addSubview(profileImage)
        view.addSubview(exitProfileButton)
        view.addSubview(nameLabel)
        view.addSubview(nickNameLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            exitProfileButton.heightAnchor.constraint(equalToConstant: 44),
            exitProfileButton.widthAnchor.constraint(equalToConstant: 44),
            exitProfileButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            exitProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nickNameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor)
        ])
    }
    
    @objc
    private func didTapExitButton() {}
    
    
}
