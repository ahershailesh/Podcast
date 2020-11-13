//
//  MockPodcastAPIService.swift
//  Podcast
//
//  Created by Shailesh Aher on 13/11/20.
//

import UIKit

enum MockPodcastError: Error {
    case fileNotFound
    case decodingError
}

class MockPodcastAPIService: IPodcastService {
    private lazy var decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchCuratedList(page: Int, completionBlock: @escaping (Result<CuratedPodcast, Error>) -> Void) {
        guard let data = getData(for: "CuratedListResponse") else {
            completionBlock(.failure(MockPodcastError.fileNotFound))
            return
        }
        guard let curatedPodcast = try? decoder.decode(CuratedPodcast.self, from: data) else {
            completionBlock(.failure(MockPodcastError.decodingError))
            return
        }
        completionBlock(.success(curatedPodcast))
    }
    
    private func getData(for fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let data = FileManager.default.contents(atPath: path)
        return data
    }
}
