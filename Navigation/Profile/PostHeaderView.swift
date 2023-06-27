//
//  PostHeaderView.swift
//  Navigation
//
//  Created by n p on 30.04.2023.
//

import UIKit

class PostHeaderView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private lazy var allPostsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All posts", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(named: "main-blue"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.1
        //shadows
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var myPostsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My posts", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(contentView)
        addSubview(allPostsButton)
        addSubview(myPostsButton)
        addTopBorder(with: UIColor.separator, andWidth: 0.33)
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            allPostsButton.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            allPostsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            allPostsButton.widthAnchor.constraint(equalToConstant: 85),
            allPostsButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            myPostsButton.leadingAnchor.constraint(equalTo: allPostsButton.trailingAnchor, constant: inset),
            myPostsButton.centerYAnchor.constraint(equalTo: allPostsButton.centerYAnchor),
            myPostsButton.widthAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    
    private func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth]
        border.frame = CGRect(x: 0, y: 5, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
}
