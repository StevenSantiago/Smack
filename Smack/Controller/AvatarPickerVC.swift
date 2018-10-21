//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Steven on 10/12/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout{
   

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var avatarSegmentControl: UISegmentedControl!
    
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Will control segmenet control for avatar versions
    @IBAction func avatarVersionPressed(_ sender: UISegmentedControl) {
        if avatarSegmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else{
            avatarType = .light
        }
        collectionView.reloadData() //Calls the collection view functions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // will use array of avatars laterJarvis
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //takes care of dynamic sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3
        // Width of Iphone SE is 320
        if UIScreen.main.bounds.width > 320{
            numberOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells)/numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)// Since it is a square both widht and height are same
    }
    
}
