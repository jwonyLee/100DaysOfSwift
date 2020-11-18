//
//  DetailViewController.swift
//  Milestone1
//
//  Created by 이지원 on 2020/11/18.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK:- Properties
    var selectedImage: String?
    
    // MARK:- Views
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc func share() {
        guard let image = imageView.image else {
            print("Do not found image")
            return
        }
        
        guard let imageName = selectedImage else {
            print("Do not found imageName")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        navigationController?.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
