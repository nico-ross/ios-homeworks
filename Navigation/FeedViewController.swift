//
//  FeedViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    let newPostItem = Post(title: "New Post")
    
    private var newPostButton: UIButton = {
        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Begin your Story", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemGray6
        
        view.addSubview(newPostButton)
        newPostButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newPostButton.frame = CGRect(x: 95, y: 120, width: 200, height: 45)
    }
    
    @objc func showDetails() {
        let postViewController = PostViewController()
        postViewController.newPostTitle = newPostItem.title
        navigationController?.pushViewController(postViewController, animated: false)
    }
}

//        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalToConstant: 200),
//            button.heightAnchor.constraint(equalToConstant: 45),
//            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            button.bottomAnchor.constraint(equalToSystemSpacingBelow: self.view.topAnchor, multiplier: 20)
//        ])
