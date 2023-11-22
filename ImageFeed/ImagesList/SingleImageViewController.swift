//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 22.11.2023.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
