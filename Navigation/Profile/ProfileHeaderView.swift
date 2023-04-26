//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by n p on 12.04.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon-256x256")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        //        imageView.layer.cornerRadius = 65
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Vasya Pupkin"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
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
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        return textField
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
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
    }
    
    private func setupConstraints() {
//        let safeAreaGuide = self.safeAreaLayoutGuide
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
//            fullNameLabel.widthAnchor.constraint(equalToConstant: fullNameLabel.intrinsicContentSize.width),
//            fullNameLabel.heightAnchor.constraint(equalToConstant: fullNameLabel.intrinsicContentSize.height),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: inset),
            
//            statusLabel.widthAnchor.constraint(equalToConstant: statusLabel.intrinsicContentSize.width),
//            statusLabel.heightAnchor.constraint(equalToConstant: statusLabel.intrinsicContentSize.height),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -5),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: -9),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            statusTextField.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: inset),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    @objc func buttonPressed() {
        guard let textFieldText = statusTextField.text else { return }
        if textFieldText == "" {
            statusLabel.text = "Waiting for something..."
        } else {
            statusLabel.text = textFieldText
        }
    }
}
    
extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
