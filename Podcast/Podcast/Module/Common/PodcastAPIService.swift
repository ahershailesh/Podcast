//
//  PodcastInteractor.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import Foundation
import Networking

enum PodcastError: Error {
    case requestBuilderError
}

enum PodcastAPI: NetworkRequestDataProvider {
    case curatedPodcast(page: Int)
    
    var path: String {
        switch self {
        case .curatedPodcast:
            return "/curated_podcasts"
        }
    }
    
    var type: NetworkRequestType {
        switch self {
        case .curatedPodcast:
            return .get
        }
    }
    
    var query: [String : String] {
        switch self {
        case .curatedPodcast(let page):
            return ["page": page.description]
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .curatedPodcast:
            return [:]
        }
    }
}

protocol IPodcastService {
    func fetchCuratedList(page: Int, completionBlock: @escaping (Result<CuratedPodcast, Error>) -> Void)
}

class PodcastAPIService: IPodcastService {
    private let executer: NetworkRequestExecutable
    private let builder: NetworkRequestConfigurator
    
    init(executer: NetworkRequestExecutable = NetworkRequestExecuter(),
         builder: NetworkRequestConfigurator) {
        self.executer = executer
        self.builder = builder
    }
    
    func fetchCuratedList(page: Int, completionBlock: @escaping (Result<CuratedPodcast, Error>) -> Void) {
        guard let request = builder.request(with: PodcastAPI.curatedPodcast(page: page)) else { return completionBlock(.failure(PodcastError.requestBuilderError)) }
        executer.execute(request: request, completionBlock: completionBlock)
    }
}
