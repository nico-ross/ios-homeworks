//
//  ProfileViewController.swift
//  Navigation
//
//  Created by n p on 07.04.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    private var widthOpenedAvatarImageView = NSLayoutConstraint()
    private var heightOpenedAvatarImageView = NSLayoutConstraint()
    private var topOpenedAvatarImageView = NSLayoutConstraint()
    private var leadingOpenedAvatarImageView = NSLayoutConstraint()
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    // Table View properties
    
    fileprivate var data = Post.make()
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Animation subviews
    
    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
    private lazy var closeImageViewButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: buttonSizeConfig)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.white
        button.alpha = 0.0
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAvatar)))
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    private lazy var openedAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "icon-256x256")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - View Controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = UIColor.systemGray6
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func addSubviews() {
        view.addSubview(profileTableView)
        
        view.addSubview(imageBackgroundView)
        view.addSubview(closeImageViewButton)
        view.addSubview(openedAvatarImageView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let inset: CGFloat = 16

        // start openedAvatarImageView constraints
        widthOpenedAvatarImageView = openedAvatarImageView.widthAnchor.constraint(equalToConstant: 130)
        heightOpenedAvatarImageView = openedAvatarImageView.heightAnchor.constraint(equalToConstant: 130)
        topOpenedAvatarImageView = openedAvatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: inset)
        leadingOpenedAvatarImageView = openedAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: inset)
        
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            // animation views constraints
            imageBackgroundView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: screenHeight),
            imageBackgroundView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),

            closeImageViewButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: inset),
            closeImageViewButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -inset),
            closeImageViewButton.widthAnchor.constraint(equalToConstant: 30),
            closeImageViewButton.heightAnchor.constraint(equalToConstant: 30),
            
            widthOpenedAvatarImageView,
            heightOpenedAvatarImageView,
            topOpenedAvatarImageView,
            leadingOpenedAvatarImageView
        ])
    }
    
    // MARK: - Animation methods
    
    public func reloadProfileTableViewData() {
        profileTableView.reloadData()
    }
    
    public func openTapAction() {
        openAvatar()
    }
    
    private func openAvatar() {
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.0) {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.15) {
                self.openedAvatarImageView.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.62) {
                self.widthOpenedAvatarImageView.constant = self.screenWidth
                self.heightOpenedAvatarImageView.constant = self.screenWidth
                self.topOpenedAvatarImageView.constant = self.screenHeight / 5
                self.leadingOpenedAvatarImageView.constant = 0.0
                
                self.imageBackgroundView.alpha = 0.8
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.62, relativeDuration: 0.38) {
                self.closeImageViewButton.alpha = 0.8
            }
        }
    }
    
    @objc private func closeAvatar() {
        UIView.animateKeyframes(withDuration: 0.6, delay: 0.0) {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.38) {
                self.closeImageViewButton.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.38, relativeDuration: 0.64) {
                self.widthOpenedAvatarImageView.constant = 130
                self.heightOpenedAvatarImageView.constant = 130
                self.topOpenedAvatarImageView.constant = 16.0
                self.leadingOpenedAvatarImageView.constant = 16.0
                self.openedAvatarImageView.alpha = 0.0
                
                self.imageBackgroundView.alpha = 0.0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc public func pushToPhotosViewController() {
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
//    private func tuneTableView() {
//        postTableView.estimatedRowHeight = 530.0
//
//        let headerView = ProfileHeaderView()
//        postTableView.setAndLayoutTableHeaderView(header: headerView)
//    }
    
}

// MARK: - TableView DataSource & Delegate

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 else { return 1 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 1 else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.identifier,
                for: indexPath
            ) as? PhotosTableViewCell else { fatalError("could not dequeueReusableCell") }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else { fatalError("could not dequeueReusableCell") }
        cell.setupCell(data[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return profileHeaderView
        case 1:
            return PostHeaderView()
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        data[indexPath.row].views += 1
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        guard indexPath.section == 1 else { return }
//        let detailTableViewCellController = DetailTableViewCellController()
//        detailTableViewCellController.setupCell(data[indexPath.row])
//        navigationController?.pushViewController(detailTableViewCellController, animated: false)
//        profileTableView.reloadRows(at: [indexPath], with: .none)
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ProfileViewController: LikeCountDelegate {
    
    func plusLikeToData(at indexPath: IndexPath) {
        data[indexPath.row].likes += 1
        data[indexPath.row].isLiked = true
//        profileTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func minusLikeFromData(at indexPath: IndexPath) {
        data[indexPath.row].likes -= 1
        data[indexPath.row].isLiked = false
//        profileTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func plusViewToData(at indexPath: IndexPath) {
        data[indexPath.row].views += 1
        
        let detailTableViewCellController = DetailTableViewCellController()
        detailTableViewCellController.setupCell(data[indexPath.row], indexPath: indexPath)
        navigationController?.pushViewController(detailTableViewCellController, animated: false)
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
