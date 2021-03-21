//
//  CommentsViewController.swift
//  PalringoPhotos
//
//  Created by Sabrina Tardio on 21/03/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var photo: Photo!
    var commentFetcher: CommentsFetcher!
    var comments: [PhotoComment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentFetcher.getPhotoComments(for: photo) { (comments) in
        }
    }
    

 

}



class CommentsVCFactory {
    func getCommentsVC(photo: Photo, commentsFetcher: CommentsFetcher) -> CommentsViewController {
        let vc = CommentsViewController()
        vc.photo = photo
        vc.commentFetcher = commentsFetcher
        return vc
    }
}
