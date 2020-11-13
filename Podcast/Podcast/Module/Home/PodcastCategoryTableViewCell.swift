//
//  PodcastCategoryTableViewCell.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

protocol PodcastCategoryTableViewCellRepresentable {
    var podcasts: [PodcastCollectionViewCellRepresentable] { get }
    var title: String { get }
}

class PodcastCategoryTableViewCellViewModel: PodcastCategoryTableViewCellRepresentable {
    
    let podcastList: PodcastItemList
    
    init(podcastList: PodcastItemList) {
        self.podcastList = podcastList
    }
    
    lazy var podcasts: [PodcastCollectionViewCellRepresentable] = {
        return podcastList.podcasts.map { PodcastCollectionViewCellViewModel(item: $0) }
    }()
    
    var title: String {
        podcastList.title ?? ""
    }
}

class PodcastCategoryTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = UILabel.construct()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var manager: PodcastListManager?
    private var viewModel: PodcastCategoryTableViewCellRepresentable?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        manager = PodcastListManager(collectionView: collectionView)
        collectionView.dataSource = manager
        setup()
        setupVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: PodcastCategoryTableViewCellRepresentable) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        manager?.podcasts = viewModel.podcasts
    }
    
    private func setup() {
        setupLayout()
        setupConstraints()
    }
    
    fileprivate func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 160)
        collectionView.collectionViewLayout = flowLayout
    }
    
    fileprivate func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            
            collectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
        ])
    }
    
    private func setupVisual() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
    }
}
