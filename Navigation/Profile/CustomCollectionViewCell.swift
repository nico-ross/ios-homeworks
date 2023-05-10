//
//  CustomCollectionViewCell.swift
//  Navigation
//
//  Created by n p on 30.04.2023.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lyfe cycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        customizeCell()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func setupCell(_ data: Photo) {
        photoImageView.image = UIImage(named: data.image)
    }
    
    // MARK: - Private methods
    
    private func customizeCell() {
        contentView.backgroundColor = .gray
    }
    
    private func addSubviews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
