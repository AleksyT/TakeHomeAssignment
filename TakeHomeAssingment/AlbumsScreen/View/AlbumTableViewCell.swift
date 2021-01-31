//
//  AlbumTableViewCell.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    typealias CellConfiguration = (thumbnailImage: UIImage?, title: String)
    
    @IBOutlet private var albumThumbnailBackgroundView: UIView!
    @IBOutlet private var albumThumbnailImageView: UIImageView!
    @IBOutlet private var albumTitleLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(configuration: CellConfiguration) {
        makeCornersRounded(albumThumbnailBackgroundView)
        makeCornersRounded(albumThumbnailImageView)
        albumTitleLabel.text = configuration.title.capitalized
        albumThumbnailImageView.image = configuration.thumbnailImage
    }
    
    private func makeCornersRounded(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
    }
    
    static func loadData(from url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }

    private func makeBackgroundDeepPurple(_  view: UIView) {
//        view.backgroundColor = Colors().deepPurple
    }
}
