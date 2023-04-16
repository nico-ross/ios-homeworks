//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by n p on 12.04.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var avatarImageView: UIView = {
        let view = UIView()
        view.layer.contents = UIImage(named: "icon-256x256")?.cgImage
//        view.layer.cornerRadius = 65
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Profile Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        //shadows
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Write new status"
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    private var statusText: String = "Waiting for something..."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            
            fullNameLabel.widthAnchor.constraint(equalToConstant: fullNameLabel.intrinsicContentSize.width),
            fullNameLabel.heightAnchor.constraint(equalToConstant: fullNameLabel.intrinsicContentSize.height),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27 + 15),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            statusLabel.widthAnchor.constraint(equalToConstant: statusLabel.intrinsicContentSize.width),
            statusLabel.heightAnchor.constraint(equalToConstant: statusLabel.intrinsicContentSize.height),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 24),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 5),

            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let textFieldText = textField.text else { return }
        if textField.text == "" {
            statusText = "Waiting for something..."
        } else {
            statusText = textFieldText
        }
    }
}
