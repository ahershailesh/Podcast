//
//  Launcher.swift
//  Podcast
//
//  Created by Shailesh Aher on 13/11/20.
//

import Networking

class Launcher {

    enum DevelomentMode {
        case debug, integration, production
    }
    
    private let serverURL = "https://listen-api.listennotes.com/api/v2"
    
    private let mode: DevelomentMode = .debug
    
    func getService() -> IPodcastService {
        switch mode {
        case .debug:
            let service = MockPodcastAPIService()
            return service
        case .integration, .production:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let executer = NetworkRequestExecuter(decoder: decoder)
            let authorizer = ListenAPIAuthorizer(configurator: NetworkRequestConstructor(serverURL: serverURL))
            let service = PodcastAPIService(executer: executer, builder: authorizer)
            return service
        }
    }
}
