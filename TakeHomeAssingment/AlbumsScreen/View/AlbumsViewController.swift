//
//  AlbumsViewController.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 30/01/2021.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    private var spinner: SpinnerView = SpinnerView()
    static let cellIdentifier = String(describing: AlbumTableViewCell.self)
    private var viewModel = AlbumsViewModel()
    private var start = 0
    
    @IBOutlet private var albumsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        getAlbums(start: start)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func onGetAlbumsCompletion() {
        DispatchQueue.main.async {
            self.albumsTableView.reloadData()
            self.hideSpinner()
        }
    }
    
    private func initTableView() {
        albumsTableView.register(UINib(nibName: Self.cellIdentifier, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: Self.cellIdentifier)
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }
    
    private func getAlbums(start: Int) {
        showSpinner()
        viewModel.getAlbums(start: start) { [weak self] result in
            switch result {
            case .success(_):
                self?.onGetAlbumsCompletion()
            case .failure(let error):
                self?.showError(error)
                self?.onGetAlbumsCompletion()
            }
        }
    }
    
    private func showSpinner() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func hideSpinner() {
        spinner.removeFromSuperview()
    }
    
    private func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: "Couldn't load albums:  \(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.hideSpinner()
        }
    }

}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? AlbumTableViewCell else {
            fatalError("Dequeued a cell of unexpected type")
        }
        let configuration = AlbumTableViewCell.CellConfiguration(thumbnailImage: viewModel.albums[indexPath.row].thumbnailImage,
                                                                 title: viewModel.albums[indexPath.row].album.title)
        cell.configure(configuration: configuration)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumCoverImage = viewModel.albums[indexPath.row].coverImage
        let albumTitle = viewModel.albums[indexPath.row].album.title
        let secondScreen = AlbumViewController(albumCoverImage: albumCoverImage, albumTitle: albumTitle)
        self.navigationController?.pushViewController(secondScreen, animated: true)
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            getAlbums(start: start + 20)
        }
    }
}
