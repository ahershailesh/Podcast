//
//  PodcastItemList.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import Foundation

struct PodcastItemList: Decodable {
    let id : String?
    let title : String?
    let podcasts : [PodcastItem]
    let sourceUrl : String?
    let description : String?
    let pubDateMs : Int?
    let sourceDomain : String?
    let listennotesUrl : String?
}
