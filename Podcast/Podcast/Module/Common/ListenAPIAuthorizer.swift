//
//  ListenAPIAuthorizer.swift
//  Podcast
//
//  Created by Shailesh Aher on 13/11/20.
//

import Networking

class ListenAPIAuthorizer: NetworkRequestConfigurator {
    
    private let configurator: NetworkRequestConfigurator
    
    init(configurator: NetworkRequestConfigurator) {
        self.configurator = configurator
    }
    
    func request(with dataProvider: NetworkRequestDataProvider) -> URLRequest? {
        var request = configurator.request(with: dataProvider)
        request?.allHTTPHeaderFields?["X-ListenAPI-Key"] = "<API-KEY>"
        return request
    }
}
