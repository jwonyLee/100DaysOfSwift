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
        // 1: Detail 뷰 컨트롤러 로딩 시도 && DetailViewController로 타입 캐스팅
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: 성공! selectedImage 프로퍼티 설정
            vc.selectedImage = pictures[indexPath.row]
            
            // 3: navigation controller로 push
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
