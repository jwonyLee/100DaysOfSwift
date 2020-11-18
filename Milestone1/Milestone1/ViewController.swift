//
//  ViewController.swift
//  Milestone1
//
//  Created by 이지원 on 2020/11/18.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK:- Properties
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        
        let fileManager: FileManager  = FileManager.default
        let path: String = Bundle.main.resourcePath!
        let items: [String] = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
        
        // *: 이미지 이름을 기준으로 정렬
        flags.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: Detail 뷰 컨트롤러 로딩 시도 && DetailViewController로 타입 캐스팅
        guard let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController else {
            print("Do not found Detail ViewController")
            return
        }
        
        // 2: 성공, 보여줄 이미지 파일 이름 넘겨주기
        vc.selectedImage = flags[indexPath.row]
        
        // 3: navigationController로 push (화면 전환)
        navigationController?.pushViewController(vc, animated: true)
    }
}

