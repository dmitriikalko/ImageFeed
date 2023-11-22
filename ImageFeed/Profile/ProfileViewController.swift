//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 09.11.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    //MARK: IBActions
    
    @IBAction func didTapLogoutButton() {
    }
}
