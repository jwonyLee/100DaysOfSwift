//
//  ViewController.swift
//  Project1
//
//  Created by 이지원 on 2020/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Properties
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}
