//
//  ViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 05.10.2023.
//

import UIKit

class ImagesListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    
    //моковые картинки
    //создаем масссив чисел и возвращаем массив строк
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }

    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        
    }

}

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
