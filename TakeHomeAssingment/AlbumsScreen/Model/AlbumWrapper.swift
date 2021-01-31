//
//  AlbumWrapper.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 30/01/2021.
//

import UIKit

struct AlbumWrapper {
    let album: Album
    let coverImage: UIImage?
    let thumbnailImage: UIImage?
    
    init(album: Album) {
        self.album = album
        coverImage = Self.getImageFromUrl(urlString: album.coverUrl)
        thumbnailImage = Self.getImageFromUrl(urlString: album.thumbnailUrl)
    }
    
    private static func getImageFromUrl(urlString: String?) -> UIImage? {
        guard let urlString = urlString,
              let url = URL(string: urlString),
              let data = Self.loadData(from: url) else { return nil }
        return UIImage(data: data)
    }
    
    private static func loadData(from url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
