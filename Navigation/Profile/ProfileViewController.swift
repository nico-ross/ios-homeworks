//
//  ProfileViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    fileprivate let data = Post.make()
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var whatTheButton: UIButton = {
        let button = UIButton()
        button.setTitle("closed for renovation", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.opacity = 0.4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonPressed(_: )), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemGray6
        navigationController?.navigationBar.isHidden = true
//        navigationItem.title = "Profile"
//        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(postTableView)
        view.addSubview(whatTheButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            postTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: whatTheButton.topAnchor),
            
            whatTheButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            whatTheButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            whatTheButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            whatTheButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func tuneTableView() {
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 520.0
        
        let headerView = ProfileHeaderView()
        postTableView.setAndLayoutTableHeaderView(header: headerView)
        
        
        postTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        print("Empty button")
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else { fatalError("could not dequeueReusableCell") }
        
        cell.setupCell(data[indexPath.row])
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = ProfileHeaderView()
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension UITableView {
    //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size =  header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}
