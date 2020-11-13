//
//  PodcastInteractor.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import Foundation

class SampleError: Error {
    
}



class PodcastAPIService {
    func fetchData(completionBlock: (Result<CuratedPodcast, Error>) -> Void) {
        guard let data = getData() else {
            completionBlock(.failure(SampleError()))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
         guard let response = try? decoder.decode(CuratedPodcast.self, from: data) else {
            completionBlock(.failure(SampleError()))
            return
        }
        completionBlock(.success(response))
    }
    
    func getData() -> Data? {
        guard let path = Bundle.main.path(forResource: "CuratedListResponse", ofType: "json") else {
            return nil
        }
        let data = FileManager.default.contents(atPath: path)
        return data
        
        
//        return mockCuratedListResponse.data(using: .utf8)
//        return handle?.availableData
    }
}
