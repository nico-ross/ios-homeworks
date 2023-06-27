//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by n p on 12.04.2023.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func reloadProfileHeaderViewData()
}

final class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    // MARK: - main subviews
        
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icon-256x256")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 65
        imageView.clipsToBounds = true
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Vasya Pupkin"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write new status"
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.textColor = .systemGray
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = UIColor(named: "main-blue")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        //shadows
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - view life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 16
        let avatarImageViewHeightAnchorConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: 130)
        avatarImageViewHeightAnchorConstraint.priority = UILayoutPriority(rawValue: 990)
        
        let avatarImageViewBottomAnchorConstraint = avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        avatarImageViewBottomAnchorConstraint.priority = UILayoutPriority(rawValue: 990)

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageViewHeightAnchorConstraint,
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            avatarImageViewBottomAnchorConstraint,
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: inset),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            statusTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: inset / 2),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            setStatusButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor)
        ])
    }
    
    private func shakeAnimation(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        
        view.layer.add(animation, forKey: "position")
    }
    
    @objc private func tapAction() {
        guard let profileViewController = self.viewController() as? ProfileViewController else { return }
        profileViewController.openTapAction()
    }
    
    @objc func buttonPressed() {
        guard let textFieldText = statusTextField.text else { return }
        if textFieldText.isEmpty {
            shakeAnimation(statusTextField)
        } else {
            statusTextField.attributedPlaceholder = NSAttributedString(
                string: textFieldText,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            )
            statusTextField.text = ""
            statusTextField.resignFirstResponder()
            ProfileViewController().reloadProfileTableViewData()
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        buttonPressed()
        return true
    }
}

extension UIView {
    
    func viewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
    
//    var viewController: UIViewController? {
//        if let responder = self as? UIViewController {
//            return responder
//        }
//        return next?.viewController
//    }
}
