//
//  FlickerFetcherTests.swift
//  PalringoPhotosTests
//
//  Created by Sabrina Tardio on 20/03/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import XCTest
@testable import PalringoPhotos

class FlickerFetcherTests: XCTestCase {



    func testOnGetPhotosUrlsAsksDataForCorrectPhotographera()  {
        let photographer = Photographers.allCases.randomElement()
        let expectedStringInURL = photographer!.rawValue
        let capturingRequester = CapturingRequester()
        let fetcher = FlickrFetcher(requester: capturingRequester)
        
        fetcher.getPhotosUrls(forAuthor: photographer!) {_ in }
        let actualURL = capturingRequester.capturedURL
        
        XCTAssertTrue(actualURL.contains(expectedStringInURL))
    }
}


class CapturingRequester: Request {
    var capturedURL: String = ""
    var completion: ((Data?, Bool) -> ())?
    var image: UIImage
    
    init(image: UIImage = UIImage()) {
        self.image = image
    }
    
    func request(url: URL, completion: @escaping (Data?, Bool) -> ()) -> URLSessionTask? {
        capturedURL = url.absoluteString
        self.completion = completion
        return nil
    }
    
    func triggerCompletion() {
        let data = image.pngData()
        completion!(data, true)
    }
}


