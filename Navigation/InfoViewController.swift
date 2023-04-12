//
//  InfoViewController.swift
//  Navigation
//
//  Created by n p on 09.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("back", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 1.00, alpha: 0.45)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("wtf?", for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "title"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        alertButton.frame = CGRect(x: 155, y: 70, width: 80, height: 40)
        actionButton.frame = CGRect(x: 155, y: 120, width: 80, height: 40)
        
        view.addSubview(alertButton)
        view.addSubview(actionButton)
        
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(buttonPressed(_: )), for: .touchUpInside)
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
