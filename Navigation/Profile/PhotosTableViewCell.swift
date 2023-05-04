//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by n p on 29.04.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    fileprivate lazy var data = Array(Photo.make().suffix(4))
    
    private lazy var titlePhotoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var nextViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor.black
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var aPhotoImageView = UIImageView()
    private var bPhotoImageView = UIImageView()
    private var cPhotoImageView = UIImageView()
    private var dPhotoImageView = UIImageView()
    
    private lazy var imageStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(self.aPhotoImageView)
        stackView.addArrangedSubview(self.bPhotoImageView)
        stackView.addArrangedSubview(self.cPhotoImageView)
        stackView.addArrangedSubview(self.dPhotoImageView)
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupPhotosImageView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotosImageView() {
        var cycleCount = 1
        [aPhotoImageView, bPhotoImageView, cPhotoImageView, dPhotoImageView].forEach {
            $0.image = UIImage(named: data[data.count - cycleCount].image)
            cycleCount += 1
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor.black
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
        }
    }
    
    private func addSubviews() {
        [titlePhotoLabel, nextViewButton, imageStackView].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 12
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let imageStackViewHeight: CGFloat = (screenWidth - inset * 2 - 24) / 4

        NSLayoutConstraint.activate([
            
            titlePhotoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            titlePhotoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            
            nextViewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nextViewButton.widthAnchor.constraint(equalToConstant: inset * 2),
            nextViewButton.heightAnchor.constraint(equalToConstant: inset * 2),
            nextViewButton.centerYAnchor.constraint(equalTo: titlePhotoLabel.centerYAnchor),

            imageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageStackView.topAnchor.constraint(equalTo: titlePhotoLabel.bottomAnchor, constant: inset),
            imageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            imageStackView.heightAnchor.constraint(equalToConstant: imageStackViewHeight)
        ])
    }
}
