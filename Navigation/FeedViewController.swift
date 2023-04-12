//
//  FeedViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    let newPostItem = Post(title: "New Post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemGray6
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 95, y: 120, width: 200, height: 45)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Begin your Story", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 1.00, alpha: 0.45)
        button.setTitleColor(.black, for: .normal)
        
        button.layer.cornerRadius = 20
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        
//        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalToConstant: 200),
//            button.heightAnchor.constraint(equalToConstant: 45),
//            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            button.bottomAnchor.constraint(equalToSystemSpacingBelow: self.view.topAnchor, multiplier: 20)
//        ])
    }
    
    @objc func showDetails() {
        let postViewController = PostViewController()
        postViewController.newPostTitle = newPostItem.title
        navigationController?.pushViewController(postViewController, animated: false)
    }
    
}
