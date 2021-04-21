//
//  DetailedFriendCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewController: UICollectionViewController {
  
  @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
  let cellReuseIdentifier = "DetailedFriendCollectionViewCell"
  var row: Int?

  var chosenFriend: User?
  var index: Int?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    
    
    // Do any additional setup after loading the view.
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
  
  @IBAction func photoAlbumButton(_ sender: Any) {
    performSegue(withIdentifier: "allPhotos", sender: self)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? DetailedFriendCollectionViewCell else
    { return UICollectionViewCell() }
    guard let userIndex = index else { return UICollectionViewCell()}
    let name = DataStorage.shared.usersArray[userIndex].name
    let age = String(DataStorage.shared.usersArray[userIndex].age)
    let image = DataStorage.shared.usersArray[userIndex].avatar ?? UIImage()
    let work = DataStorage.shared.usersArray[userIndex].job
    cell.avatarLabel.shadow(anyImage: image, anyView: cell.viewForShadow)
    cell.configure(name: name, image: image, age: age, work: work!)
    cell.buttonPressed = {
      self.performSegue(withIdentifier: "allPhotos", sender: (Any).self)
    }
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "allPhotos" {
      let controller = segue.destination as! PhotosCollectionViewController
      controller.index.self = index
    }
  }
  
  
  
}
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  
   // Uncomment this method to specify if the specified item should be selected
   
  
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
  


extension DetailedFriendCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 400.0, height: 900.0)
  }
}
