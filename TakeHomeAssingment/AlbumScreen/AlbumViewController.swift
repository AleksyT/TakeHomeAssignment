//
//  AlbumViewController.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 30/01/2021.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private var albumCoverImage: UIImage?
    private var albumTitle: String
    
    @IBOutlet private var albumCoverImageView: UIImageView!
    @IBOutlet private var albumTitleLabel: UILabel!
    
    init(albumCoverImage: UIImage?, albumTitle: String) {
        self.albumCoverImage = albumCoverImage
        self.albumTitle = albumTitle
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumCoverImageView.image = albumCoverImage
        albumCoverImageView.layer.borderWidth = 1
        albumCoverImageView.layer.borderColor = UIColor.Theme.foreground.cgColor
        albumTitleLabel.text = albumTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
