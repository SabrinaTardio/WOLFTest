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

    func testAskCommentsForCorrectPhotoOnInitialisation() {
        let fetcher = MockCommentFetcher()
        let expectedPhoto = Photo(id: "someId", name: "someName", url: URL(string: "https://someurl")!)
        let vc = CommentsVCFactory().getCommentsVC(photo: expectedPhoto, commentsFetcher: fetcher)
        vc.displayOnScreen()
        let actualPhoto = fetcher.capturedPhoto
        
        XCTAssertEqual(actualPhoto, expectedPhoto)
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
    
    func getPhotoComments(for photo: Photo, completion: @escaping ([PhotoComment]) -> ()) {
        self.capturedPhoto = photo
    }
    
    
}
