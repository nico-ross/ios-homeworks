//
//  DetailTableViewCellController.swift
//  Navigation
//
//  Created by n p on 30.05.2023.
//

import UIKit

final class DetailTableViewCellController: UIViewController {
    
    private var isLiked = false
    private var indexPath = IndexPath()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: buttonSizeConfig)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.systemGray3
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.textColor = UIColor.black
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likesImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemRed
        return imageView
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var likesCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(self.likesImageView)
        stackView.addArrangedSubview(self.likesCountLabel)
        
        stackView.isUserInteractionEnabled = true
//        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeTapAction)))
        return stackView
    }()
    
    private lazy var viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemGray3
        return imageView
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var viewsCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(self.viewsImageView)
        stackView.addArrangedSubview(self.viewsCountLabel)
        return stackView
    }()
    
    private lazy var noCommentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No comments yet."
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    public func setupCell(_ data: Post, indexPath: IndexPath) {
        authorLabel.text = data.author
        postImageView.image = UIImage(named: data.image)
        descriptionLabel.text = data.description
        likesCountLabel.text = String(data.likes)
        viewsCountLabel.text = String(data.views)
        
        isLiked = data.isLiked
        self.indexPath = indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLikeImage(isLiked)
    }
    
    public func setLikeImage(_ isLiked: Bool) {
        if isLiked {
            likesImageView.image = UIImage(systemName: "heart.fill")
        } else {
            likesImageView.image = UIImage(systemName: "heart")
        }
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        tabBarController?.tabBar.isHidden = true
        
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backTapped))
    }
    
    private func addSubviews() {
        [authorLabel, closeButton, postImageView, descriptionLabel, likesCountStackView, viewsCountStackView, noCommentsLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let inset: CGFloat = 16
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width

        NSLayoutConstraint.activate([
            
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -inset),
            authorLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: inset),
            
            closeButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -inset),
            closeButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: inset),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            postImageView.heightAnchor.constraint(equalToConstant: screenWidth),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -inset),
            
            likesCountStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesCountStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            viewsCountStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsCountStackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            noCommentsLabel.topAnchor.constraint(equalTo: likesCountLabel.bottomAnchor, constant: inset * 2),
            noCommentsLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
    }
    
    @objc func closeButtonTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
}
