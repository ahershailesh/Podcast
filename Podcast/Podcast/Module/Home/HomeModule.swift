//
//  HomeModule.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

class HomeModule {
    
    func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewController.setup(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        window?.rootViewController = navController
    }
}
