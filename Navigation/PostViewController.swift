//
//  PostViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var newPostTitle: String?
    
    private lazy var barButtonItem: UIBarButtonItem = {
        let burButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(showDetails)
        )
        return burButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = newPostTitle
        view.backgroundColor = UIColor.systemGray6
//        view.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 1.00, alpha: 1.00)
        
        navigationItem.setRightBarButton(barButtonItem, animated: false)
    }
    
    @objc func showDetails() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
