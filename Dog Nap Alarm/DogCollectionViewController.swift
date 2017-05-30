//
//  DogCollectionViewController.swift
//  Dog Nap Alarm
//
//  Created by Alex Madrzyk on 2017-05-29.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DogCollectionViewController: UICollectionViewController {
    
    var dogImages: [UIImage] = [];
    var dogImagesChecked: [UIImage] = [];
    var checkArray = [Int]();
    
    struct Storyboard {
        static let dogCell = "DogCell"
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 2.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        dogImages += [
            #imageLiteral(resourceName: "shiba_hex"),
            #imageLiteral(resourceName: "pug_hex"),
            #imageLiteral(resourceName: "beagle_hex"),
            #imageLiteral(resourceName: "chihuahua_hex")
        ]
        
        dogImagesChecked += [
            #imageLiteral(resourceName: "shiba_checked"),
            #imageLiteral(resourceName: "pug_checked"),
            #imageLiteral(resourceName: "beagle_checked"),
            #imageLiteral(resourceName: "chihuahua_checked")
        ]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogImages.count;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.dogCell, for: indexPath) as! DogImageCollectionViewCell
    
        // Configure the cell
        cell.DogImageView.image = dogImages[indexPath.item]
        
        if checkArray.contains(indexPath.row) {
            cell.DogImageView.image = dogImagesChecked[indexPath.item]
        } else {
            cell.DogImageView.image = dogImages[indexPath.item]
        }

        return cell
    }

    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if checkArray.contains(indexPath.row) {
            let index = checkArray.index(of: indexPath.row)
            checkArray.remove(at: index!)
            collectionView.reloadItems(at: [indexPath])
        } else {
            checkArray.append(indexPath.row)
            collectionView.reloadItems(at: [indexPath])
        }
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
