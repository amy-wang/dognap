//
//  DogCollectionViewController.swift
//  Dog Nap Alarm
//
//  Created by Alex Madrzyk on 2017-05-29.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class DogCollectionViewController: UICollectionViewController {
    
    var dogImages: [UIImage] = [];
    var dogImagesChecked: [UIImage] = [];
    var dogNames: [String] = [];
    var checkArray = [Int]();
    var chooseButton: UIButton?;
    let settings = UserDefaults.standard;
    
    
    struct Storyboard {
        private let reuseIdentifier = "Cell"
        static let dogCell = "DogCell"
        static let footerButton = "FooterViewID"
        static let dogChosenSegueToSettings = "DogChosenSegueToSettings"
        static let dogChosenSegueToAlarm = "DogChosenSegueToAlarm"
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
        
        dogNames += [
            "Shiba",
            "Pug",
            "Beagle",
            "Chihuahua"
        ]
        
        chooseButton = addChooseButton();
        
        // Check Pre-selected Dog
        let dogName = settings.string(forKey: "dogName");
        if (dogName != nil) {
            let dogIndex = dogNames.index(of: dogName!);
            checkArray.append(dogIndex!);
            let dogIndexPath = IndexPath(row: dogIndex!, section: 0);
            collectionView?.reloadItems(at: [dogIndexPath])
        }
    }

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Update images on select/deselect
        if (checkArray.isEmpty) {
            checkArray.append(indexPath.row)
        }
        else {
            if checkArray.contains(indexPath.row) {
                let index = checkArray.index(of: indexPath.row)
                checkArray.remove(at: index!)
            }
            else if (checkArray.count == 1){
                checkArray.append(indexPath.row)
                let removedIndexRow = checkArray.removeFirst()
                let removedIndexPath = IndexPath(row: removedIndexRow, section: 0);
                collectionView.reloadItems(at: [removedIndexPath])
            }
        }
        
        // Update choose button based on selection
        if checkArray.count == 1 {
            chooseButton!.isEnabled = true;
            chooseButton!.isUserInteractionEnabled = true;
        } else {
            chooseButton!.isEnabled = false;
            chooseButton!.isUserInteractionEnabled = false;
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    fileprivate func addChooseButton() -> UIButton {
        let button = UIButton()
        
        // Button View Settings
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CHOOSE", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.backgroundColor = UIColor(hex: "00FF80")
        button.accessibilityIdentifier = "ChooseButtonID"
        
        // Button Action + Disable Before Choice
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        button.isEnabled = false;
        button.isUserInteractionEnabled = false;
        self.view.addSubview(button)
        
        // Constraints
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        return button;
    }
    
    func pressButton(button: UIButton) {
        let dogIndex = checkArray.first;
        let dogName = dogNames[dogIndex!];
        settings.set(dogName, forKey: "dogName")
        
        if !settings.bool(forKey: "firstBootCompleted") {
            settings.set(true, forKey: "firstBootCompleted");
            performSegue(withIdentifier: Storyboard.dogChosenSegueToAlarm, sender: button)
        } else {
            performSegue(withIdentifier: Storyboard.dogChosenSegueToSettings, sender: button)
        }
    }
}


