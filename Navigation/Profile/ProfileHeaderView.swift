//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by n p on 12.04.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profilePicture: UIView
    let profileNameLable: UILabel
    let statusLabel: UILabel
    let statusButton: UIButton
    let statusTextField: UITextField
    private var statusText: String
    
    override init(frame: CGRect) {
        profilePicture = UIView()
        profileNameLable = UILabel()
        statusLabel = UILabel()
        statusButton = UIButton()
        statusTextField = UITextField()
        statusText = "Waiting for something..."
        super.init(frame: frame)
        
        // add subviews
        addSubview(profilePicture)
        addSubview(profileNameLable)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(statusTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //construct profilePictureView
        profilePicture.frame = CGRect(
            x: 16,
            y: safeAreaInsets.top + 16,
            width: 130,
            height: 130
        )
        profilePicture.layer.contents = UIImage(named: "icon-256x256")?.cgImage
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.borderWidth = 3
        
        //construct profileNameLable
        profileNameLable.text = "Profile Name"
        profileNameLable.textColor = .black
        profileNameLable.frame = CGRect(
            x: 166,
            y: safeAreaInsets.top + 27 + 15,
            width: profileNameLable.intrinsicContentSize.width,
            height: profileNameLable.intrinsicContentSize.height
        )
        profileNameLable.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        
        //construct statusLabel
        statusLabel.text = statusText
        statusLabel.textColor = .gray
        statusLabel.frame = CGRect(
            x: 166,
            y: safeAreaInsets.top + 106.4 - 15,
            width: statusLabel.intrinsicContentSize.width,
            height: statusLabel.intrinsicContentSize.height
        )
        statusLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        //construct statusButton
        statusButton.setTitle("Show status", for: .normal)
        statusButton.frame = CGRect(
            x: 16,
            y: safeAreaInsets.top + 162,
            width: 358,
            height: 50
        )
        statusButton.backgroundColor = UIColor.systemBlue
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.cornerRadius = 14
        //shadows
        statusButton.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4.0
        statusButton.layer.shadowColor = UIColor.black.cgColor
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        //construct statusTextField
        statusTextField.frame = CGRect(
            x: 166,
            y: safeAreaInsets.top + 115,
            width: 208,
            height: 40
        )
        statusTextField.layer.backgroundColor = UIColor.white.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1
        statusTextField.textColor = .black
        statusTextField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

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
