//
//  InfoViewController.swift
//  Navigation
//
//  Created by n p on 09.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("wtf?", for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)

        return button
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.backgroundColor = UIColor(named: "main-blue")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonPressed(_: )), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        title = "title"
    }
    
    private func addSubviews() {
        view.addSubview(alertButton)
        view.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            alertButton.widthAnchor.constraint(equalToConstant: 80),
            alertButton.heightAnchor.constraint(equalToConstant: 40),
            alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            
            actionButton.widthAnchor.constraint(equalToConstant: 80),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: self.alertButton.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Mystery", message: "What Does the Fox Say?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Jacha-chow", style: .default) { (action:UIAlertAction!) in
            self.view.backgroundColor = .systemPink
            print("Jacha-chacha-chacha-chow!")
        }
        let noAction = UIAlertAction(title: "Fraka-kow", style: .cancel) { (action:UIAlertAction!) in
            self.view.backgroundColor = .systemPurple
            print("Fraka-kaka-kaka-kaka-kow!")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
                
        present(alertController, animated: true, completion:nil)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
