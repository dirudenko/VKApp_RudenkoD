//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit

class FriendsViewController: UIViewController {
  var friendIndex: Int?
  var charIndex: Int?
  let nibIdentifier = "FriendTableViewCell"
  
  @IBOutlet weak var friendsTableView: UITableView!
  
  @IBOutlet weak var charPeekerControl: CharPeekerControl!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    charPeekerControl.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    //button.setTitle(String(charIndex[0]), for: .normal)
    self.view.bringSubviewToFront(charPeekerControl)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      controller.index.self = friendIndex
    }
  }
}
// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataStorage.shared.usersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    let name = DataStorage.shared.usersArray[indexPath.row].name
    let image = DataStorage.shared.usersArray[indexPath.row].avatar ?? UIImage()
    cell.configure(name: name, image: image)
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      DataStorage.shared.usersArray.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    friendIndex = indexPath.row
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}

extension FriendsViewController: NameDelegate {
  func didPressButton(button: UIButton) {
    let char = button.titleLabel!.text
    var names = [String]()
    for item in DataStorage.shared.usersArray{
      names.append(item.name)
    }
    for item in names {
      if item.first == char?.first {
        print(item.self.startIndex)
        let index = names.firstIndex(of: item.self)!
        let indexPath = IndexPath(row:  index, section: 0)
        friendsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
    }
  }
}








/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
