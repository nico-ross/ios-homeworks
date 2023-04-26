//
//  FeedViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    let newPostItem = NewPost(title: "New Post")
    
    private lazy var firstPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Begin your Story", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        //shadows
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start your Story", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        //shadows
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        
        stackView.addArrangedSubview(self.firstPostButton)
        stackView.addArrangedSubview(self.secondPostButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        navigationItem.title = "Feed"
        view.backgroundColor = UIColor.systemGray6
//        view.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 1.00, alpha: 1.00)
    }
    
    private func addSubviews() {
        view.addSubview(buttonStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            buttonStackView.widthAnchor.constraint(equalToConstant: 190),
            buttonStackView.heightAnchor.constraint(equalToConstant: 110),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showDetails() {
        let postViewController = PostViewController()
        postViewController.newPostTitle = newPostItem.title
        navigationController?.pushViewController(postViewController, animated: false)
    }
}
