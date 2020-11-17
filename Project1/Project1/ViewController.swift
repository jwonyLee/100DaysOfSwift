//
//  ViewController.swift
//  Project1
//
//  Created by 이지원 on 2020/11/17.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK:- Properties
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager: FileManager = FileManager.default
        let path: String = Bundle.main.resourcePath!
        let items: [String] = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        // *: 이미지 이름을 기준으로 정렬
        pictures.sort()
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
        // 1: Detail 뷰 컨트롤러 로딩 시도 && DetailViewController로 타입 캐스팅
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: 성공! selectedImage 프로퍼티 설정
            vc.selectedImage = pictures[indexPath.row]
            
            // *: 이름 지정
            // Picture X of Y, Y is total number of images and X is selected picture's position in the array.
            // Make sure you count from 1 rather than
            vc.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
            
            // 3: navigation controller로 push
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
