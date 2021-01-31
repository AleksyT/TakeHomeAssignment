//
//  TakeHomeAssingmentUITests.swift
//  TakeHomeAssingmentUITests
//
//  Created by Aleksy Tylkowski on 31/01/2021.
//

import XCTest

class TakeHomeAssingmentUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    func testAlbumsAreLoadedOnEntry() {
        sleep(10)
        XCTAssertTrue(app.staticTexts["Accusamus Beatae Ad Facilis Cum Similique Qui Sunt"].exists)
        let imageView = app.images["AlbumsViewController.AlbumTableViewCell.AlbumThumbnailImageView"]
        XCTAssertNotNil(imageView)
    }
    
    func testNextScreenIsPresented() {
        sleep(10)
        let firstAlbum = app.tables.staticTexts["Accusamus Beatae Ad Facilis Cum Similique Qui Sunt"]
        firstAlbum.tap()
        XCTAssertTrue(app.staticTexts["Accusamus Beatae Ad Facilis Cum Similique Qui Sunt"].exists)
        let imageView = app.images["AlbumViewController.AlbumCoverImageView"]
        XCTAssertNotNil(imageView)
        app.navigationBars["TakeHomeAssingment.AlbumView"].buttons["Back"].tap()
    }
}
