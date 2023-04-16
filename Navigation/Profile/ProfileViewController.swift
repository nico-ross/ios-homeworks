//
//  ProfileViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var isTapped = false
    private var topTitleLayout = [NSLayoutConstraint]()
    private var bottomTitleLayout = [NSLayoutConstraint]()
    
    private lazy var profileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moveTitleButton: UIButton = {
        let button = UIButton()
        button.layer.contents = UIImage(systemName: "platter.filled.bottom.and.arrow.down.iphone")?.cgImage
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
        
        topTitleLayout = ([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            moveTitleButton.widthAnchor.constraint(equalToConstant: 25),
            moveTitleButton.heightAnchor.constraint(equalToConstant: 40),
            moveTitleButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -6),
            moveTitleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -150)
        ])
        
        bottomTitleLayout = ([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            moveTitleButton.widthAnchor.constraint(equalToConstant: 25),
            moveTitleButton.heightAnchor.constraint(equalToConstant: 40),
            moveTitleButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -6),
            moveTitleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -150)
        ])
        
        NSLayoutConstraint.activate(topTitleLayout)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if isTapped {
            moveTitleButton.layer.contents = UIImage(systemName: "platter.filled.bottom.and.arrow.down.iphone")?.cgImage
            NSLayoutConstraint.deactivate(bottomTitleLayout)
            NSLayoutConstraint.activate(topTitleLayout)
            isTapped = false
        } else {
            moveTitleButton.layer.contents = UIImage(systemName: "platter.filled.top.and.arrow.up.iphone")?.cgImage
            NSLayoutConstraint.deactivate(topTitleLayout)
            NSLayoutConstraint.activate(bottomTitleLayout)
            isTapped = true
        }
    }
}
