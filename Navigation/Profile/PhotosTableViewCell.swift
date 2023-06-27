//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by n p on 29.04.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    fileprivate lazy var data = Array(Photo.make().suffix(4))
    
    private lazy var whiteContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private lazy var photosButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Photos", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(named: "main-blue"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.1
        //shadows
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var videosButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Videos", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var musicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Music", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
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
        
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonPressed)))
        return stackView
    }()
    
    private lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemBackground
        button.setTitle("Upload photo", for: .normal)
        button.setTitleColor(UIColor(named: "main-blue"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemBackground
        button.setTitle("Show all ❯", for: .normal)
        button.setTitleColor(UIColor(named: "main-blue"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        
        stackView.addArrangedSubview(self.uploadPhotoButton)
        stackView.addArrangedSubview(self.showAllButton)
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
        [whiteContentView, photosButton, videosButton, musicButton, imageStackView, bottomButtonStackView].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        let inset: CGFloat = 12
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let imageStackViewHeight: CGFloat = (screenWidth - inset * 2 - 24) / 4

        NSLayoutConstraint.activate([
            
            whiteContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            photosButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosButton.widthAnchor.constraint(equalToConstant: 85),
            
            videosButton.leadingAnchor.constraint(equalTo: photosButton.trailingAnchor, constant: inset),
            videosButton.centerYAnchor.constraint(equalTo: photosButton.centerYAnchor),
            videosButton.widthAnchor.constraint(equalToConstant: 85),
            
            musicButton.leadingAnchor.constraint(equalTo: videosButton.trailingAnchor, constant: inset),
            musicButton.centerYAnchor.constraint(equalTo: photosButton.centerYAnchor),
            musicButton.widthAnchor.constraint(equalToConstant: 85),

            imageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageStackView.topAnchor.constraint(equalTo: photosButton.bottomAnchor, constant: inset),
            imageStackView.heightAnchor.constraint(equalToConstant: imageStackViewHeight),
                        
            bottomButtonStackView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 10),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            bottomButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func buttonPressed() {
        guard let profileViewController = self.viewController() as? ProfileViewController else { return }
        profileViewController.pushToPhotosViewController()
    }
}
