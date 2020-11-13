//
//  PodcastCollectionViewCell.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

protocol PodcastCollectionViewCellRepresentable {
    var title: String { get }
    var thumbnailURL: URL? { get }
    
    func open()
}

class PodcastCollectionViewCellViewModel: PodcastCollectionViewCellRepresentable {
    private let item: PodcastItem
    
    init(item: PodcastItem) {
        self.item = item
    }
    
    var title: String {
        return item.title ?? ""
    }
    var thumbnailURL: URL? {
        return URL(string: item.thumbnail ?? "")
    }
    
    func open() {
        
    }
}

class PodcastCollectionViewCell: UICollectionViewCell {
    
    private lazy var thumbnailImage: UIImageView = UIImageView.construct()
    private lazy var titleLabel: UILabel = UILabel.construct()
    
    private var viewModel: PodcastCollectionViewCellRepresentable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: PodcastCollectionViewCellRepresentable) {
        titleLabel.text = viewModel.title
        thumbnailImage.image = UIImage(named: "business-on-the-bright-side")
    }
    
    private func setup() {
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        [thumbnailImage, titleLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 100),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor),
        ])
    }
    
    private func setupVisual() {
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        
        thumbnailImage.layer.cornerRadius = 4.0
        thumbnailImage.layer.masksToBounds = true
    }
}
