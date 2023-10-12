//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 06.10.2023.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {
    
    
    static let reusedIdentifier = "ImagesListCell"
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
}
