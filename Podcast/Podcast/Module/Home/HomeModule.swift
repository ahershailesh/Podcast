//
//  HomeModule.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit
import Networking

class HomeModule {
    
    private let podcastAPIService: IPodcastService
    
    init(podcastAPIService: IPodcastService) {
        self.podcastAPIService = podcastAPIService
    }
    
    func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(interactor: podcastAPIService)
        viewController.setup(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        window?.rootViewController = navController
    }
}
