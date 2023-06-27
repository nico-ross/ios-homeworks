//
//  LoginViewController.swift
//  Navigation
//
//  Created by n p on 23.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let userLogin: String = "net@net.net"
    private let userPassword: String = "12345678"
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mailTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.returnKeyType = UIReturnKeyType.next
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = UIColor.systemGray6
        
        textField.delegate = self
        textField.tag = 0
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.backgroundColor = UIColor.systemGray6
        textField.isSecureTextEntry = true
        
        textField.delegate = self
        textField.tag = 1
        
        return textField
    }()
    
    private lazy var textFieldStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        
        stackView.backgroundColor = UIColor.lightGray
        stackView.spacing = 0.5
        
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(self.mailTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "main-blue")
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        //        button.layer.contents = UIImage(named: "blue-pixel")?.cgImage
        button.contentMode = .scaleToFill
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginDataConformLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "empty"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "alert-red")
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.alpha = 0.0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(textFieldStackView)
        contentView.addSubview(loginButton)
        contentView.addSubview(loginDataConformLabel)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            
            textFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            loginDataConformLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginDataConformLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginDataConformLabel.bottomAnchor.constraint(equalTo: textFieldStackView.topAnchor, constant: -16)
        ])
    }
    
    @objc func loginButtonPressed() {
        guard checkLoginRequirement() else { return }
        loginDataConformLabel.alpha = 0.0
        
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: false)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

extension LoginViewController {
    
    enum LoginDataRequirement {
        case invalidEmail, shortPass, invalidAllData
    }
    
    private func showLoginDataConformLabel(_ alert: LoginDataRequirement) {
        switch alert {
        case .invalidEmail:
            loginDataConformLabel.text = "Invalid email format"
        case .shortPass:
            loginDataConformLabel.text = "Password must contain at least 8 characters"
        case .invalidAllData:
            loginDataConformLabel.text = "Invalid email format \nPassword must contain at least 8 characters"
        }
        loginDataConformLabel.alpha = 1.0
    }
    
    func showLoginFailedAlert() {
        let alertController = UIAlertController(
            title: nil,
            message: "Incorrect email or password. \nPlease try again.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    private func checkLoginRequirement() -> Bool {
        let passwordRequirement = NSPredicate(format: "SELF MATCHES %@", "^.{8,}$")
        let emailRequirement = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")

        if let mailText = mailTextField.text, let passwordText = passwordTextField.text {
            guard !mailText.isEmpty, !passwordText.isEmpty else {
                textFieldStackView.layer.borderColor = UIColor(named: "alert-red")?.cgColor
                textFieldStackView.layer.borderWidth = 0.9
                textFieldStackView.backgroundColor = UIColor(named: "alert-red")
                
                mailTextField.attributedPlaceholder = NSAttributedString(
                    string: "Enter your email",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "alert-red") as Any]
                )
                passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: "Enter your password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "alert-red") as Any]
                )
                return false
            }
            
            if !emailRequirement.evaluate(with: mailText) && !passwordRequirement.evaluate(with: passwordText) {
                showLoginDataConformLabel(.invalidAllData)
                return false
            } else if !emailRequirement.evaluate(with: mailText) {
                showLoginDataConformLabel(.invalidEmail)
                return false
            } else if !passwordRequirement.evaluate(with: passwordText) {
                showLoginDataConformLabel(.shortPass)
                return false
            }
            
            guard mailText == userLogin, passwordText == userPassword else {
                showLoginFailedAlert()
                return false
            }
        }
        return true
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            self.loginButtonPressed()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldStackView.backgroundColor = UIColor.lightGray
        textFieldStackView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldStackView.layer.borderWidth = 0.5
        loginDataConformLabel.alpha = 0.0
        
        if let _ = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            mailTextField.attributedPlaceholder = NSAttributedString(
                string: "Email",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText]
            )
        } else {
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText]
            )
        }
    }
}
