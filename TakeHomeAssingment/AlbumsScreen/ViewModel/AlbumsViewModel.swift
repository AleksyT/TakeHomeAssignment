//
//  AlbumsViewModel.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import Foundation

class AlbumsViewModel {
    typealias CompletionHandler = (Result<Void, Error>) -> Void
    private static let url = "https://jsonplaceholder.typicode.com/photos"
    var albums: [AlbumWrapper] = []
    
    init() { }
    
    func getAlbums(start: Int, completion: @escaping CompletionHandler) {
        var urlComps = URLComponents(string: Self.url)
        let limitQueryItem = URLQueryItem(name: "_limit", value: "\(20)")
        let startQueryItem = URLQueryItem(name: "_start", value: "\(start)")
        urlComps?.queryItems = [limitQueryItem, startQueryItem]
        
        guard let url = urlComps?.url else { return }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let albums = try decoder.decode([Album].self, from: data)
                    self.albums.append(contentsOf: albums.map { return AlbumWrapper(album: $0) })
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
