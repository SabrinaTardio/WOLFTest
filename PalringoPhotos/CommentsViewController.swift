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
    var requeter: Request!
    var comments: [PhotoComment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.dataSource = self
        loadPhoto()
        loadComments()
    }
    
    private func loadComments() {
        commentFetcher.getPhotoComments(for: photo) { (comments) in
            self.comments = comments
            self.commentsTableView.reloadData()
        }
    }
    
    private func loadPhoto() {
        _ = requeter.request(url: photo.url) { (data, _) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.photoImageView?.image = image
        }
    }

}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCellTableViewCell
        cell.authorLabel.text = comments[indexPath.row].author
        cell.commentLabel.text = comments[indexPath.row].comment
        return cell
    }
    
    
}



class CommentsVCFactory {
    func getCommentsVC(photo: Photo, commentsFetcher: CommentsFetcher, requester: Request = CachedRequest()) -> CommentsViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsViewController
        vc.photo = photo
        vc.commentFetcher = commentsFetcher
        vc.requeter = requester
        return vc
    }
}


