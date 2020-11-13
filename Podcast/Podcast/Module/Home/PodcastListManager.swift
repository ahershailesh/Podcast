//
//  PodcastListManager.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

class PodcastListManager: NSObject, UICollectionViewDataSource {
    
    private weak var collectionView: UICollectionView?
    var podcasts: [PodcastCollectionViewCellRepresentable] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setup()
    }
    
    private func setup() {
        collectionView?.register(PodcastCollectionViewCell.self, forCellWithReuseIdentifier: PodcastCollectionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCollectionViewCell.reuseId, for: indexPath) as? PodcastCollectionViewCell
        cell?.backgroundColor = .white
        cell?.setup(viewModel: podcasts[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
