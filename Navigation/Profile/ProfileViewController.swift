//
//  ProfileViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moveTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile Button", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.opacity = 0.4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonPressed(_: )), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
//        view.backgroundColor = .lightGray
        view.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 1.00, alpha: 1.00)
        
        view.addSubview(profileHeaderView)
        view.addSubview(moveTitleButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            moveTitleButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            moveTitleButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            moveTitleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: 0),
            moveTitleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        print("Empty button")
    }
}
