//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 06.10.2023.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {
    
    //MARK: -IB Outlets
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    //MARK: -Public Propertis
    static let reusedIdentifier = "ImagesListCell"
}
