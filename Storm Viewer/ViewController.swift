//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Ksusha on 24.03.2022.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default // работа с файловой системой (поиск файлов)
        let path = Bundle.main.resourcePath! // путь к изображениям
        let items = try! fm.contentsOfDirectory(atPath: path) // массив строк с именами файлов
     
        for item in items { //
            if item.hasPrefix("Image"){ // MARK: место где осуществляется отбор картинок только с началом в названии nnsl (ИЗМЕНИТЬ )
                // эта картинка для загрузки
                pictures.append(item)// на этом моменте у нас есть массив с нужными картинками
            }
            pictures.sort()
        }
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

