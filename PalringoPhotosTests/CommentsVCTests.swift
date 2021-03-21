//
//  CommentsVCTests.swift
//  PalringoPhotosTests
//
//  Created by Sabrina Tardio on 21/03/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import XCTest
@testable import PalringoPhotos


class CommentsVCTests: XCTestCase {
    
    var fetcher: MockCommentFetcher!
    var requester: CapturingRequester!
    var vc: CommentsViewController!
    let expectedPhotoURL = "https://someurl"
    var expectedPhoto: Photo!
    let expectedImage = UIImage(named: "testImage")!
    let comments = [PhotoComment(id: "1", author: "author1", comment: "bella"), PhotoComment(id: "2", author: "author2", comment: "bellissima"), PhotoComment(id: "3", author: "author3", comment: "bellissimissima")]
    
    override func setUp() {
        expectedPhoto = Photo(id: "someId", name: "someName", url: URL(string: expectedPhotoURL)!)
        requester = CapturingRequester(image: expectedImage)
        fetcher = MockCommentFetcher(comments: comments)
        vc = CommentsVCFactory().getCommentsVC(photo: expectedPhoto, commentsFetcher: fetcher, requester: requester)
        vc.displayOnScreen()
    }
    
    override func tearDown() {
        vc = nil
        fetcher = nil
        requester = nil
    }

    func testAskCommentsForCorrectPhotoOnInitialisation() {
        let actualPhoto = fetcher.capturedPhoto
        
        XCTAssertEqual(actualPhoto, expectedPhoto)
    }
    
    func testTableViewHasCorrectNumberOfRows() {
        fetcher.triggerCompletion()
        let expectedNumberOfRows = comments.count
        let actualNumberOfRows = vc.commentsTableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(actualNumberOfRows, expectedNumberOfRows)
    }
    
    func testTableViewShowsCorrectAuthor() {
        fetcher.triggerCompletion()
        let randomIndex = Int.random(in: 0..<3)
        let expectedAuthor = comments[randomIndex].author
        let tableViewSelectedCell = vc.commentsTableView.cellForRow(at: IndexPath(row: randomIndex, section: 0)) as! CommentCellTableViewCell
        let actualAuthor = tableViewSelectedCell.authorLabel.text
        
        XCTAssertEqual(actualAuthor, expectedAuthor)
    }
    
    func testTableViewShowsCorrectComment() {
        fetcher.triggerCompletion()
        let randomIndex = Int.random(in: 0..<3)
        let expectedComment = comments[randomIndex].comment
        let tableViewSelectedCell = vc.commentsTableView.cellForRow(at: IndexPath(row: randomIndex, section: 0)) as! CommentCellTableViewCell
        let actualComment = tableViewSelectedCell.commentLabel.text
        
        XCTAssertEqual(actualComment, expectedComment)
    }
    
    func testAskImageForCorrectURL() {
        let actualURL = requester.capturedURL
        
        XCTAssertEqual(actualURL, expectedPhotoURL)
    }
    
    func testShowsCorrectImage() {
        requester.triggerCompletion()
        let actualImage = vc.photoImageView.image
        
        XCTAssertEqual(actualImage?.pngData(), expectedImage.pngData())
    }

}

extension UIViewController {
    func displayOnScreen() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
        window.rootViewController = self
        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 5)
    }
}

class MockCommentFetcher: CommentsFetcher {
    var capturedPhoto: Photo?
    var comments: [PhotoComment]
    var completion: (([PhotoComment]) -> ())?
    
    init(comments: [PhotoComment] = []) {
        self.comments = comments
    }
    
    func getPhotoComments(for photo: Photo, completion: @escaping ([PhotoComment]) -> ()) {
        self.capturedPhoto = photo
        self.completion = completion
    }
    
    func triggerCompletion() {
        completion!(comments)
    }
    
    
}
