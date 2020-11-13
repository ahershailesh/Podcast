//
//  PodCastItem.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import Foundation

struct PodcastItem: Decodable {
    let id: String?
    let image: String?
    let title: String?
    let publisher: String?
    let thumbnail: String?
    let listenScore: Float?
    let listennotesUrl: String?
    let listenScoreGlobalRank: String?
}
