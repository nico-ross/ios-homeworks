//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by n p on 26.04.2023.
//

import UIKit


final class CustomTableViewCell: UITableViewCell {
    
//    private lazy var cellContentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setupCell(_ data: Post) {
        authorLabel.text = data.author
        postImageView.image = UIImage(named: data.image)
        descriptionLabel.text = data.description
        likesCountLabel.text = "Likes: \(String(data.likes))"
        viewsCountLabel.text = "Views: \(String(data.views))"
    }
    
    private func addSubviews() {
        [authorLabel, postImageView, descriptionLabel, likesCountLabel, viewsCountLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 16
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width

        NSLayoutConstraint.activate([
//            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
//            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
//            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
//            authorLabel.widthAnchor.constraint(equalToConstant: self.intrinsicContentSize.width),
//            authorLabel.heightAnchor.constraint(equalToConstant: self.intrinsicContentSize.height),
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
            
            likesCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesCountLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            viewsCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsCountLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
