//
//  CuratedPodcast.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import Foundation

struct CuratedPodcast: Decodable {
    let total: Int
    let hasNext: Bool
    let pageNumber: Int
    let hasPrevious: Bool
    let curatedLists: [PodcastItemList]
    let nextPageNumber: Int
    let previousPageNumber: Int
}
