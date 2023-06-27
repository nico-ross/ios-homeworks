//
//  PhotosViewController.swift
//  Navigation
//
//  Created by n p on 29.04.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    fileprivate let data = Array(Photo.make().reversed())
    
    private let collectionViewCell = CustomCollectionViewCell()
    private var initialImageRect: CGRect = .zero
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.systemGray6
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Animation subviews
    
    private lazy var imageBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        view.backgroundColor = .black
        view.alpha = 0.85
        return view
    }()
    
    private lazy var closeImageViewButton: UIButton = {
        let button = UIButton(frame: CGRect(x: screenWidth - 66, y: 80, width: 50, height: 50))
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: buttonSizeConfig)
        
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.white
//        button.alpha = 0.0
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    private lazy var openedAvatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        photosCollectionView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemGray6
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Photos"
    }
    
    private func addSubviews() {
        view.addSubview(photosCollectionView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photosCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            photosCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func animateImage(_ image: UIImage?) {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(imageBackgroundView)
        view.addSubview(closeImageViewButton)
        view.addSubview(openedAvatarImageView)
        
        openedAvatarImageView.image = image
        
        UIView.animate(withDuration: 0.45) {
            self.openedAvatarImageView.alpha = 1.0
            self.openedAvatarImageView.center = self.view.center
        }
    }
    
    private func animateImageToInitial() {
        UIView.animate(withDuration: 0.25) {
            self.openedAvatarImageView.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenWidth)
            self.openedAvatarImageView.alpha = 0.0
        } completion: { _ in
            self.openedAvatarImageView.removeFromSuperview()
        }
    }
    
    @objc private func closeAvatar() {
        closeImageViewButton.removeFromSuperview()
        imageBackgroundView.removeFromSuperview()
        animateImageToInitial()

        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - CollectionView DataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomCollectionViewCell else { fatalError("could not dequeueReusableCell") }
        cell.setupCell(data[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension PhotosViewController: CustomCollectionViewCellDelegate {
    func didTapImage(_ image: UIImage?) {
        animateImage(image)
    }
    
    
}

// MARK: - CollectionView Delegate

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - inset * 4) / 3
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
}
