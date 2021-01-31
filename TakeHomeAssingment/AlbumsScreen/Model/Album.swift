//
//  Album.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import UIKit

struct Album: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    var coverUrl: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case coverUrl = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
