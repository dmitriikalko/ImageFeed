//
//  ViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 05.10.2023.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    //моковые картинки
    //создаем масссив чисел и возвращаем массив строк
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    //вычисляем дату
    private lazy var dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: -Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    // seguay
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier { // 1
            let viewController = segue.destination as! SingleImageViewController // 2
            let indexPath = sender as! IndexPath // 3
            let image = UIImage(named: photosName[indexPath.row]) // 4
            viewController.image = image // 5
        } else {
            super.prepare(for: segue, sender: sender) // 6
        }
    }
}

// MARK: -Ex UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
        
    }
    //динамическая высота
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
        
    }
    
}

//MARK: -Ex UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //используем метод который из всех зарегестрированных в таблице, возвращает ячейку по зараннее добавленному идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reusedIdentifier, for: indexPath)
        
        //используем приведение типов если чтото пойдет не так возвратим обычную ячейку
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
            
        }
        
        //метод который пока ничего не делает
        configCell(for: imageListCell, with: indexPath)
        
        //возвращаем ячейку
        return imageListCell
        
        //return UITableViewCell()
    }
}

//MARK: -EX ImaeListViewController
extension ImagesListViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        cell.cellImage.image = image
        cell.dateLabel.text = dateFormater.string(from: Date())
        
        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "Active_Like") : UIImage(named: "No_Active_Like")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
