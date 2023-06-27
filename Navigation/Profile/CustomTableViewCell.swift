//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by n p on 26.04.2023.
//

import UIKit

protocol LikeCountDelegate: AnyObject {
    func plusLikeToData(at indexPath: IndexPath)
    func minusLikeFromData(at indexPath: IndexPath)
    
    func plusViewToData(at indexPath: IndexPath)
}


final class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: LikeCountDelegate?
    
    private var indexPath = IndexPath()
    private var isLiked = false
    
    private lazy var whiteContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(detailTapAction)))
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .natural
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemRed
        
        return imageView
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
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
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeTapAction)))
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
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
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
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        postImageView.image = nil
        descriptionLabel.text = nil
        likesCountLabel.text = nil
        viewsCountLabel.text = nil
    }
    
    func setupCell(_ data: Post, indexPath: IndexPath) {
        self.indexPath = indexPath
        authorLabel.text = data.author
        postImageView.image = UIImage(named: data.image)
        descriptionLabel.text = data.description
        likesCountLabel.text = String(data.likes)
        viewsCountLabel.text = String(data.views)
    }
    
    private func addSubviews() {
        [whiteContentView, authorLabel, postImageView, descriptionLabel, likesCountStackView, viewsCountStackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 16
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        let likesCountStackViewBottomAnchorConstraint = likesCountStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        likesCountStackViewBottomAnchorConstraint.priority = UILayoutPriority(rawValue: 990)
        
        let viewsCountStackViewBottomAnchorConstraint = viewsCountStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        viewsCountStackViewBottomAnchorConstraint.priority = UILayoutPriority(rawValue: 990)
        
        NSLayoutConstraint.activate([
            
            whiteContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            postImageView.heightAnchor.constraint(equalToConstant: screenWidth),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            likesCountStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesCountStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesCountStackViewBottomAnchorConstraint,
            
            viewsCountStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsCountStackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsCountStackViewBottomAnchorConstraint
        ])
    }
    
    @objc func likeTapAction() {
        guard let likesCount = Int(likesCountLabel.text ?? "0") else { return }
        
        if !isLiked {
            likesCountLabel.text = (likesCount + 1).description
            likesImageView.image = UIImage(systemName: "heart.fill")
            isLiked = true
            delegate?.plusLikeToData(at: indexPath)
        } else {
            likesCountLabel.text = (likesCount - 1).description
            likesImageView.image = UIImage(systemName: "heart")
            isLiked = false
            delegate?.minusLikeFromData(at: indexPath)
        }
    }
    
    @objc func detailTapAction() {
        
        guard let viewsCount = Int(viewsCountLabel.text ?? "0") else { return }
        viewsCountLabel.text = (viewsCount + 1).description
        
        delegate?.plusViewToData(at: indexPath)
    }
}
