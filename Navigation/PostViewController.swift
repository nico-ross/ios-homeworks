//
//  PostViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var newPostTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newPostTitle
        view.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 1.00, alpha: 1.00)
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(showDetails)
        )
        navigationItem.setRightBarButton(barButtonItem, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func showDetails() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
