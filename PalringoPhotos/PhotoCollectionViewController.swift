//
//  PhotoCollectionViewController.swift
//  PalringoPhotos
//
//  Created by Benjamin Briggs on 14/10/2016.
//  Copyright © 2016 Palringo. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Photographers.dersascha.displayName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView?.collectionViewLayout.invalidateLayout()
        }, completion: nil)
        
        super.viewWillTransition(to: size, with: coordinator)
    }



    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource = collectionView.dataSource as? ImageDataSource
        
        if let photo = dataSource?.photos[indexPath.section][indexPath.item], let fetcher = dataSource?.fetcher {
            let commetsVC = CommentsVCFactory().getCommentsVC(photo: photo, commentsFetcher: fetcher)
            commetsVC.navigationItem.title = photo.name
            self.show(commetsVC, sender: self)
        }
    }
    
}
